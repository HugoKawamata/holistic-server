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
  return async (user: UserGQL) => {
    const words = await pg("user_words")
      .where({
        "user_words.user_id": user.id,
        status: "COMPLETED",
      })
      .join("words", "words.id", "=", "user_words.word_id")
      .join("set_lessons", "set_lessons.id", "=", "words.set_lesson_id")
      .where({
        course_id: dbCourse.id,
      });

    return words.map((word) => marshalUserWord(word));
  };
};
