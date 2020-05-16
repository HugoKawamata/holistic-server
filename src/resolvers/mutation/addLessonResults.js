/* @flow */
import type { ResultCT } from "../../types/client";
import type {
  CharacterDB,
  CharacterResultDB,
  WordResultDB,
} from "../../types/db";

type BeforeCreateWordResultDB = $Diff<WordResultDB, { id: number }>;

type BeforeCreateCharacterResultDB = $Diff<CharacterResultDB, { id: number }>;

// Can be either word result or character result
type AmbiguousResultDB = WordResultDB | CharacterResultDB;

type BeforeCreateAmbiguousResultDB =
  | BeforeCreateWordResultDB
  | BeforeCreateCharacterResultDB;

export const marshalInputResultsToWordResults = (
  results: Array<ResultCT>,
  userId: string,
  now: mixed
): Array<BeforeCreateWordResultDB> => {
  return results
    .map((result: ResultCT): BeforeCreateWordResultDB | null => {
      const parsedUserId = parseInt(userId, 10);
      const parsedWordId = parseInt(result.objectId, 10);
      if (parsedWordId == null) {
        return null;
      }
      return {
        user_id: parsedUserId,
        word_id: parsedWordId,
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
              user_id: parseInt(userId, 10),
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

// This is an N+1 query - should try to optimise in the future
export const insertOrUpdateUserWordOrCharacter = (
  pg: any, // eslint-disable-line flowtype/no-weak-types
  trx: mixed,
  resultIds: Array<number>,
  marshalledResults: Array<BeforeCreateAmbiguousResultDB>,
  objectName: "word" | "character",
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
          `${insert} ON CONFLICT (user_id, ${objectName}_id) DO UPDATE SET proficiency = EXCLUDED.proficiency, result_ids = EXCLUDED.result_ids`
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
        .then((newWordResultIds): BeforeCreateWordResultDB => {
          return insertOrUpdateUserWordOrCharacter(
            pg,
            trx,
            newWordResultIds,
            // $FlowFixMe this this annoying
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
            .where({ user_id: userId, set_lesson_id: setLessonId })
            .update({ status: "COMPLETE" })
            .transacting(trx);

          // Line up next lesson
          const lesson = await pg("set_lessons")
            .where({
              id: setLessonId,
            })
            .transacting(trx)
            .then((lessons) => lessons[0]);

          const unlocks = lesson.unlocks_ids.split(",").map((unlockId) => ({
            user_id: userId,
            set_lesson_id: unlockId,
            status: "AVAILABLE",
          }));

          await pg("user_set_lessons").insert(unlocks).transacting(trx);
        })
        .then(trx.commit)
        .catch(trx.rollback);
    });

    return true;
  };
};
