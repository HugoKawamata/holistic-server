/* @flow */

import type {
  UserSetLessonJoinSetLessonDB,
  UserCourseJoinCourseDB,
} from "../../types/db";
import { hiraganaRomajiMap } from "../util";

const hiraganaToRomajiCSV = (hiragana) => {
  let splitQuestion = [];
  let mutateHiragana = hiragana;

  // We have to go backwards due to lya/lyu/lyo/sokuon
  while (mutateHiragana.length > 0) {
    let current = mutateHiragana[mutateHiragana.length - 1];
    mutateHiragana = mutateHiragana.slice(0, mutateHiragana.length - 1);
    if (Object.keys(hiraganaRomajiMap).includes(current)) {
      splitQuestion = [hiraganaRomajiMap[current], ...splitQuestion];
    } else if (current === "っ") {
      // Strip the first character off the most recent romaji
      splitQuestion = [splitQuestion[0][0], ...splitQuestion];
    } else {
      // It was a lya/lyu/lyo
      current = `${mutateHiragana[mutateHiragana.length - 1]}${current}`;
      // Remove the next hiragana character
      mutateHiragana = mutateHiragana.slice(0, mutateHiragana.length - 1);
      splitQuestion = [hiraganaRomajiMap[current], ...splitQuestion];
    }
  }
  return splitQuestion.reduce((csv, kana) => `${csv},${kana}`);
};

// heta as in 下手 (bad at). This was the most succinct so I thought I'd use some Japanese :)
const getHetaWords = async (pg, wordIds, userId, howMany = 2) => {
  const hetaWords = await pg("user_words")
    .where({ user_id: userId })
    .whereNotIn("word_id", wordIds) // Don't get the words for the current test
    .join("words", "user_words.word_id", "=", "words.id")
    .orderBy("proficiency")
    .limit(howMany);
  return (
    hetaWords
      // If the worst words are above a certain threshold, just don't include them
      .filter((word) => word.proficiency < 0.9)
      .map((word) => ({
        id: word.id,
        image: word.image,
        emoji: word.emoji,
        hiragana: word.hiragana,
        // No introduction for heta words
      }))
  );
};

export const kanaLessonResolver = async (
  lesson: UserSetLessonJoinSetLessonDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const words = await pg("words").where("set_lesson_id", lesson.id);
  const hetaWords =
    lesson.id === "HIRAGANA_A"
      ? []
      : await getHetaWords(
          pg,
          words.map((w) => w.id),
          lesson.user_id
        );
  const lectures = await pg("lectures").where("set_lesson_id", lesson.id);
  const testables = words.concat(hetaWords).map((word) => ({
    objectId: word.id,
    objectType: "WORD",
    question: {
      type: "J_WORD",
      image: word.image,
      emoji: word.emoji,
      text: word.hiragana,
    },
    answer: {
      type: "ROMAJI",
      text: hiraganaToRomajiCSV(word.hiragana),
    },
    introduction: word.introduction,
  }));

  return {
    id: lesson.id,
    title: lesson.title,
    image: lesson.image,
    lectures: lectures.sort((a, b) => {
      if (a.id < b.id) {
        return -1;
      }
      if (a.id > b.id) {
        return 1;
      }
      return 0;
    }),
    testables,
  };
};

export const lessonResolver = async (
  lesson: UserSetLessonJoinSetLessonDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  switch (lesson.course_id) {
    case "HIRAGANA":
      return kanaLessonResolver(lesson, pg);
    case "KATAKANA":
      return kanaLessonResolver(lesson, pg);
    default:
      return null;
  }
};

export const availableLessonsResolver = async (
  course: UserCourseJoinCourseDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const availableLessons = await pg("set_lessons")
    .join(
      "user_set_lessons",
      "user_set_lessons.set_lesson_id",
      "=",
      "set_lessons.id"
    )
    .where({
      "set_lessons.course_id": course.id,
      "user_set_lessons.status": "AVAILABLE",
    });
  return availableLessons.map((lesson) => lessonResolver(lesson, pg));
};

export const completedLessonsResolver = async (
  course: UserCourseJoinCourseDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const completeLessons = await pg("set_lessons")
    .join(
      "user_set_lessons",
      "user_set_lessons.set_lesson_id",
      "=",
      "set_lessons.id"
    )
    .where({
      "set_lessons.course_id": course.id,
      "user_set_lessons.status": "COMPLETE",
    });
  return completeLessons.map((lesson) => lessonResolver(lesson, pg));
};
