// @flow

export const kanaLevelArray = [
  null,
  "HIRAGANA-A",
  "HIRAGANA-KA",
  "HIRAGANA-GA",
  "HIRAGANA-SA",
  "HIRAGANA-ZA",
  "HIRAGANA-TA",
  "HIRAGANA-DA",
  "HIRAGANA-NA",
  "HIRAGANA-N",
  "HIRAGANA-HA",
  "HIRAGANA-BA",
  "HIRAGANA-MA",
  "HIRAGANA-WA",
  "HIRAGANA-YA",
  "HIRAGANA-LYA",
  "HIRAGANA-RA",
  "HIRAGANA-PA",

  "KATAKANA-A",
  "KATAKANA-KA",
  "KATAKANA-GA",
  "KATAKANA-SA",
  "KATAKANA-ZA",
  "KATAKANA-TA",
  "KATAKANA-DA",
  "KATAKANA-NA",
  "KATAKANA-N",
  "KATAKANA-HA",
  "KATAKANA-BA",
  "KATAKANA-MA",
  "KATAKANA-WA",
  "KATAKANA-YA",
  "KATAKANA-LYA",
  "KATAKANA-RA",
  "KATAKANA-PA",
  "COMPLETE",
];

export const kanaLevelToIntMap = {
  // null is considered the 0th element here
  "HIRAGANA-A": 1,
  "HIRAGANA-KA": 2,
  "HIRAGANA-GA": 3,
  "HIRAGANA-SA": 4,
  "HIRAGANA-ZA": 5,
  "HIRAGANA-TA": 6,
  "HIRAGANA-DA": 7,
  "HIRAGANA-NA": 8,
  "HIRAGANA-N": 9,
  "HIRAGANA-HA": 10,
  "HIRAGANA-BA": 11,
  "HIRAGANA-MA": 12,
  "HIRAGANA-WA": 13,
  "HIRAGANA-YA": 14,
  "HIRAGANA-LYA": 15,
  "HIRAGANA-RA": 16,
  "HIRAGANA-PA": 17,

  "KATAKANA-A": 18,
  "KATAKANA-KA": 19,
  "KATAKANA-GA": 20,
  "KATAKANA-SA": 21,
  "KATAKANA-ZA": 22,
  "KATAKANA-TA": 23,
  "KATAKANA-DA": 24,
  "KATAKANA-NA": 25,
  "KATAKANA-N": 26,
  "KATAKANA-HA": 27,
  "KATAKANA-BA": 28,
  "KATAKANA-MA": 29,
  "KATAKANA-WA": 30,
  "KATAKANA-YA": 31,
  "KATAKANA-LYA": 32,
  "KATAKANA-RA": 33,
  "KATAKANA-PA": 34,
  COMPLETE: 35,
};

export const marshalInputResultsToWordResults = (results, userId, now) => {
  return results.map((result) => ({
    user_id: parseInt(userId),
    word_id: parseInt(result.objectId),
    answers: result.answers,
    marks: result.marks,
    created_at: now,
  }));
};

export const marshalInputResultsToCharacterResults = async (
  results,
  userId,
  pg
) => {
  return await pg("characters")
    .columns("id", "character")
    .select()
    .whereIn(
      "character",
      results.map((result) => result.text)
    )
    .then((characters) => {
      return results.map((result) => ({
        user_id: parseInt(userId),
        character_id: parseInt(
          characters.find(({ id, character }) => character === result.text).id
        ),
        answers: result.answers,
        marks: result.marks,
        created_at: pg.fn.now(),
      }));
    });
};

export const calcProficiency = (results) => {
  const tec = 0.7; // Time emphasis coefficient
  const mostRecentTestTimestamp = Math.max(
    ...results.map((r) => +r.created_at)
  );
  let summedDailyWeights = 0;
  const summedDailyProficiencies = results.reduce((sum, result) => {
    const timesWrong = result.marks.filter((m) => m === "INCORRECT").length;
    const daysFromMostRecentTest = Math.ceil(
      (+result.created_at - mostRecentTestTimestamp) / (1000 * 60 * 60 * 24)
    );
    const dailyWeight = Math.pow(tec, daysFromMostRecentTest);
    summedDailyWeights += dailyWeight;
    return sum + (1 / (1 + timesWrong)) * dailyWeight;
  }, 0);
  return summedDailyProficiencies / summedDailyWeights;
};

// This is an N+1 query - should try to optimise in the future
export const insertOrUpdateUserWordOrCharacter = (
  pg,
  trx,
  resultIds,
  unmarshalledResults,
  userId,
  objectName
) => {
  unmarshalledResults.map((res, i) => {
    const proficiency = 1;
    const baseTuple = {
      user_id: userId,
      [`${objectName}_id`]: res.objectId,
      proficiency: proficiency,
    };

    const insert = pg(`user_${objectName}s`)
      .insert({
        ...baseTuple,
        result_ids: [resultIds[i].id],
      })
      .toString();

    const update = pg(`user_${objectName}s`)
      .update({
        ...baseTuple,
        result_ids: pg.raw("array_append(colName, ?)", [resultIds[i].id]),
      })
      .whereRaw(
        `user_${objectName}s.${objectName}_id = '${res.objectId}' AND user_${objectName}s.user_id = '${userId}'`
      )
      .toString();

    return pg
      .raw(
        `${insert} ON CONFLICT (user_id, ${objectName}_id) UPDATE SET ${update}`
      )
      .transacting(trx);
    //});
  });
};

export const addLessonResultsResolver = (pg) => {
  return async (_, { results, userId, content }) => {
    const wordResults = results.filter((res) => res.objectType === "WORD");
    const characterResults = results.filter(
      (res) => res.objectType === "CHARACTER"
    );
    console.log("wordresults", wordResults);
    console.log("characterresults", characterResults);

    const marshalledWordResults = marshalInputResultsToWordResults(
      wordResults,
      userId,
      pg.fn.now()
    );
    console.log("marshalledWordResults", marshalledWordResults);

    const marshalledCharacterResults = await marshalInputResultsToCharacterResults(
      characterResults,
      userId,
      pg
    );
    console.log("marshalledCharacterResults", marshalledCharacterResults);

    pg.transaction((trx) => {
      pg("word_results")
        .insert(marshalledWordResults, ["id"])
        .transacting(trx)
        .then((newWordResultIds) => {
          return insertOrUpdateUserWordOrCharacter(
            pg,
            trx,
            newWordResultIds,
            wordResults,
            userId,
            "word"
          );
        })
        .then(() => {
          return pg("character_results")
            .insert(marshalledCharacterResults, ["id"])
            .transacting(trx)
            .then((characterResultIds) => {
              return insertOrUpdateUserWordOrCharacter(
                pg,
                trx,
                characterResultIds,
                characterResults,
                userId,
                "character"
              );
            });
        })
        .then(() => {
          // Update kana level if applicable
          if (content !== "OTHER") {
            pg("accounts")
              .where({ id: userId })
              .update({ kana_level: content })
              .transacting(trx);
          }
        })
        .then(trx.commit)
        .catch(trx.rollback);
    });

    return true;
  };
};
