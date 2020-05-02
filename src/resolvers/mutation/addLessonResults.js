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
  marshalledResults,
  objectName,
  userId
) => {
  const tableName = `user_${objectName}s`;
  const objectIdName = `${objectName}_id`;

  return pg(`${objectName}_results`)
    .select(["id", "marks", "created_at", objectIdName])
    .where({
      user_id: userId,
    })
    .whereIn(
      objectIdName,
      marshalledResults.map((marsh) => marsh[objectIdName])
    )
    .transacting(trx)
    .then((allResults) => {
      const proficiency = calcProficiency(allResults);
      console.log(proficiency);

      const insert = pg(tableName)
        .insert(
          marshalledResults.map((res, i) => ({
            user_id: res.user_id,
            [objectIdName]: res[objectIdName],
            proficiency: calcProficiency(
              allResults.filter((r) => r[objectIdName] === res[objectIdName])
            ),
          }))
        )
        .transacting(trx)
        .toString();

      return pg
        .raw(
          `${insert} ON CONFLICT (user_id, ${objectName}_id) DO UPDATE SET proficiency = EXCLUDED.proficiency, result_ids = EXCLUDED.result_ids`
        )
        .transacting(trx);
    });
};

export const addLessonResultsResolver = (pg) => {
  return async (_, { results, userId, content }) => {
    const wordResults = results.filter((res) => res.objectType === "WORD");
    const characterResults = results.filter(
      (res) => res.objectType === "CHARACTER"
    );

    const marshalledWordResults = marshalInputResultsToWordResults(
      wordResults,
      userId,
      pg.fn.now()
    );

    const marshalledCharacterResults = await marshalInputResultsToCharacterResults(
      characterResults,
      userId,
      pg
    );

    pg.transaction((trx) => {
      pg("word_results")
        .insert(marshalledWordResults, ["id"])
        .transacting(trx)
        .then((newWordResultIds) => {
          return insertOrUpdateUserWordOrCharacter(
            pg,
            trx,
            newWordResultIds,
            marshalledWordResults,
            "word",
            userId
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
                marshalledCharacterResults,
                "character",
                userId
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
