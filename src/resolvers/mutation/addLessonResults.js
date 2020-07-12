/* @flow */
import type { ResultCT } from "../../types/client";
import type {
  CharacterDB,
  CharacterResultDB,
  TestableResultDB,
  WordResultDB,
} from "../../types/db";

type BeforeCreateWordResultDB = $Diff<WordResultDB, { id: number }>;

type BeforeCreateTestableResultDB = $Diff<TestableResultDB, { id: number }>;

type BeforeCreateCharacterResultDB = $Diff<CharacterResultDB, { id: number }>;

// Can be either word result or character result
type AmbiguousResultDB = WordResultDB | CharacterResultDB | TestableResultDB;

export const marshalInputResultsToWordResults = (
  results: Array<ResultCT>,
  userId: string,
  now: mixed
): Array<BeforeCreateWordResultDB> => {
  return results
    .map((result: ResultCT): BeforeCreateWordResultDB | null => {
      const parsedWordId = parseInt(result.objectId, 10);
      if (parsedWordId == null) {
        return null;
      }
      return {
        user_id: userId,
        word_id: parsedWordId,
        answers: result.answers,
        marks: result.marks,
        created_at: now,
      };
    })
    .filter(Boolean);
};

export const marshalInputResultsToTestableResults = (
  results: Array<ResultCT>,
  userId: string,
  now: mixed
): Array<BeforeCreateTestableResultDB> => {
  return results
    .map((result: ResultCT): BeforeCreateTestableResultDB | null => {
      const parsedTestableId = parseInt(result.objectId, 10);
      if (parsedTestableId == null) {
        return null;
      }
      return {
        user_id: userId,
        testable_id: parsedTestableId,
        answers: result.answers,
        marks: result.marks,
        created_at: now,
      };
    })
    .filter(Boolean);
};

export const marshalInputResultsToCharacterResults = async (
  results: Array<ResultCT>,
  userId: string,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return pg("characters")
    .columns("id", "character")
    .select()
    .whereIn(
      "character",
      results.map((result) => result.text)
    )
    .then(
      (
        characters: Array<CharacterDB>
      ): Array<BeforeCreateCharacterResultDB> => {
        return results
          .map((result) => {
            const char = characters.find(
              ({ character }: CharacterDB) => character === result.text
            );
            if (char == null) {
              return null;
            }
            return {
              user_id: userId,
              character_id: parseInt(char.id, 10),
              answers: result.answers,
              marks: result.marks,
              created_at: pg.fn.now(),
            };
          })
          .filter(Boolean);
      }
    );
};

export const calcProficiency = (results: Array<AmbiguousResultDB>) => {
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
    const dailyWeight = tec ** daysFromMostRecentTest;
    summedDailyWeights += dailyWeight;
    return sum + (1 / (1 + timesWrong)) * dailyWeight;
  }, 0);
  return summedDailyProficiencies / summedDailyWeights;
};

type ArrayOfAmbiguousResults =
  | Array<BeforeCreateWordResultDB>
  | Array<BeforeCreateTestableResultDB>
  | Array<BeforeCreateCharacterResultDB>;

export const insertOrUpdateUserWordOrCharacter = (
  pg: any, // eslint-disable-line flowtype/no-weak-types
  trx: mixed,
  // $FlowFixMe Weird flow error that doesn't like mixed array types
  marshalledResults: ArrayOfAmbiguousResults,
  objectName: "word" | "character" | "testable",
  userId: string
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
      const insert = pg(tableName)
        .insert(
          marshalledResults.map((res) => ({
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
          `${insert} ON CONFLICT (user_id, ${objectName}_id) DO UPDATE SET proficiency = EXCLUDED.proficiency`
        )
        .transacting(trx);
    });
};

export const addLessonResultsResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (
    _: mixed,
    {
      results,
      userId,
      setLessonId,
    }: { results: Array<ResultCT>, userId: string, setLessonId: string }
  ) => {
    const wordResults = results.filter((res) => res.objectType === "WORD");
    const testableResults = results.filter(
      (res) => res.objectType === "TESTABLE"
    );
    const characterResults = results.filter(
      (res) => res.objectType === "CHARACTER"
    );

    const marshalledWordResults = marshalInputResultsToWordResults(
      wordResults,
      userId,
      pg.fn.now()
    );

    const marshalledTestableResults = marshalInputResultsToTestableResults(
      testableResults,
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
        .then(() => {
          return insertOrUpdateUserWordOrCharacter(
            pg,
            trx,
            // $FlowFixMe this this annoying
            marshalledWordResults,
            "word",
            userId
          );
        })
        .then(() => {
          if (marshalledCharacterResults.length > 0) {
            return pg("character_results")
              .insert(marshalledCharacterResults, ["id"])
              .transacting(trx)
              .then(() => {
                return insertOrUpdateUserWordOrCharacter(
                  pg,
                  trx,
                  marshalledCharacterResults,
                  "character",
                  userId
                );
              });
          }
          return null;
        })
        .then(() => {
          if (marshalledTestableResults.length > 0) {
            return pg("testable_results")
              .insert(marshalledTestableResults, ["id"])
              .transacting(trx)
              .then(() => {
                return insertOrUpdateUserWordOrCharacter(
                  pg,
                  trx,
                  marshalledTestableResults,
                  "testable",
                  userId
                );
              });
          }
          return null;
        })
        .then(async () => {
          // Complete current lesson
          const completeLesson = await pg("user_set_lessons")
            .where({
              user_id: userId,
              set_lesson_id: setLessonId,
            })
            .transacting(trx);

          // If it's already complete, dont update
          // We want completed_at to be the time it was originally completed at, for sorting
          if (completeLesson.status !== "COMPLETE") {
            await pg("user_set_lessons")
              .where({ user_id: userId, set_lesson_id: setLessonId })
              .update({ status: "COMPLETE", completed_at: pg.fn.now() })
              .transacting(trx);
          }

          // Line up next lesson
          const lesson = await pg("set_lessons")
            .where({
              id: setLessonId,
            })
            .transacting(trx)
            .then((lessons) => lessons[0]);

          if (lesson.unlocks_ids === "NEXT_COURSE") {
            const completeCourse = await pg("user_courses")
              .where({
                user_id: userId,
                course_id: lesson.course_id,
              })
              .transacting(trx);

            // If it's already complete, dont update
            if (completeCourse.status !== "COMPLETE") {
              await pg("user_courses")
                .where({ user_id: userId, course_id: lesson.course_id })
                .update({ status: "COMPLETE", completed_at: pg.fn.now() })
                .transacting(trx);
            }

            const course = await pg("courses")
              .where({ id: lesson.course_id })
              .transacting(trx);

            const unlocks = course.unlocks_ids.split(",").map((unlockId) => ({
              user_id: userId,
              course_id: unlockId,
              status: "AVAILABLE",
            }));

            const addNewCourse = pg("user_courses")
              .insert(unlocks)
              .transacting(trx);

            await pg
              .raw(
                `${addNewCourse} ON CONFLICT (user_id, course_id) DO NOTHING`
              )
              .transacting(trx);
          } else {
            const unlocks = lesson.unlocks_ids.split(",").map((unlockId) => ({
              user_id: userId,
              set_lesson_id: unlockId,
              status: "AVAILABLE",
            }));

            const addNewLesson = pg("user_set_lessons")
              .insert(unlocks)
              .transacting(trx);
            await pg
              .raw(
                `${addNewLesson} ON CONFLICT (user_id, set_lesson_id) DO NOTHING`
              )
              .transacting(trx);
          }
        })
        .then(trx.commit)
        .catch(trx.rollback);
    });

    return true;
  };
};
