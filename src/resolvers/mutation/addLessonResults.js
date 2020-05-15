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
  return async (_, { results, userId, set_lesson_id }) => {
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
        .then(async () => {
          // Complete current lesson
          await pg("user_set_lessons")
            .where({ user_id: userId, set_lesson_id })
            .update({ status: "COMPLETE" })
            .transacting(trx);

          // Line up next lesson
          const lesson = await pg("set_lessons")
            .where({
              id: set_lesson_id,
            })
            .transacting(trx)
            .then((lessons) => lessons[0]);

          const unlocks = lesson.unlocks_ids.split(",").map((unlockId) => ({
            user_id: userId,
            set_lesson_id: unlockId,
            status: "AVAILABLE",
          }));

          await pg("user_set_lessons").insert(unlocks);
        })
        .then(trx.commit)
        .catch(trx.rollback);
    });

    return true;
  };
};
