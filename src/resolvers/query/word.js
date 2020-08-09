/* @flow */
import type {
  UserCourseJoinCourseDB,
  UserWordJoinWordDB,
} from "../../types/db";
import type { UserGQL } from "../../types/gql";

const marshalUserWord = (word: UserWordJoinWordDB) => {
  return {
    id: word.id,
    japanese: word.japanese,
    hiragana: word.hiragana,
    english: word.english,
    emoji: word.emoji,
  };
};

export const courseLearnedWordsResolver = (
  dbCourse: UserCourseJoinCourseDB,
  userId: string,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  // eslint-disable-next-line no-unused-vars
  return async (user: UserGQL) => {
    const words = await pg("user_words")
      .select([
        "user_words.*",
        "words.*",
        "set_lessons.*",
        "set_lessons.id as set_lesson_id",
      ])
      .where({
        "user_words.user_id": userId,
      })
      .join("words", "words.id", "=", "user_words.word_id")
      .join("set_lessons", "set_lesson_id", "=", "words.set_lesson_id")
      .where({
        course_id: dbCourse.id,
      });

    return words.map((word) => marshalUserWord(word));
  };
};
