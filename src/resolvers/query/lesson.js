/* @flow */

import type {
  UserSetLessonJoinSetLessonDB,
  UserCourseJoinCourseDB,
  SetLessonDB,
  CourseDB,
} from "../../types/db";
import { hiraganaRomajiMap } from "../util";

const getObjectType = (questionType) => {
  switch (questionType) {
    case "J_SENTENCE":
    case "E_SENTENCE":
      return "TESTABLE";
    case "J_WORD":
    case "E_WORD":
      return "WORD";
    default:
      return "TESTABLE";
  }
};

export const parseWithHighlights = async (
  sentence: ?string,
  pg: any, // eslint-disable-line flowtype/no-weak-types
  focusWordId?: ?number
): Promise<?{
  furigana: string,
  japanese: string,
}> => {
  if (sentence == null) {
    return null;
  }
  // Each segment can be:
  // - a series of punctuation, including spaces
  // - a series of japanese characters (and english full stops which delimit particles)
  // - anything enclosed within curly braces
  const segments = sentence.match(
    // eslint-disable-next-line no-irregular-whitespace
    /[　、。「」？！]+|[一-龠ぁ-ゔァ-ヴー.]+|\{.*\}/g
  );
  if (segments == null) {
    return {
      japanese: sentence,
      furigana: sentence,
    };
  }
  // Particles are separated from the connecting word by an English full stop character
  const splitSegments = segments.map((segment) => segment.split(".")); // English dot
  // Split segments is an array of arrays.
  // EG. [["word", "particle"], ["word"], ["word", "particle", "particle"]]
  const wordsToCheck = splitSegments.map((segment) => segment[0]);

  const dbWords = await pg("words")
    .leftJoin("user_words", "user_words.word_id", "=", "words.id")
    .whereIn("japanese", wordsToCheck)
    .orWhereIn("hiragana", wordsToCheck)
    .select("japanese", "hiragana", "user_id", "id");

  const highlights = splitSegments.map((segment) => {
    // segment[0] can be:
    // - a series of punctuation, including spaces
    // - a japanese word
    // - anything enclosed within curly braces
    const dbWord = dbWords.find((word) => word.japanese === segment[0]);
    const word =
      // eslint-disable-next-line no-nested-ternary
      dbWord == null
        ? segment[0]
        : dbWord.user_id != null // eslint-disable-line no-nested-ternary
        ? `[${segment[0]}]`
        : dbWord.id === focusWordId
        ? `<${segment[0]}>`
        : segment[0];
    const furigana =
      // eslint-disable-next-line no-nested-ternary
      dbWord == null
        ? null
        : dbWord.user_id != null // eslint-disable-line no-nested-ternary
        ? `[${dbWord.hiragana}]`
        : dbWord.id === focusWordId
        ? `<${dbWord.hiragana}>`
        : dbWord.hiragana;

    const particles = segment
      .slice(1)
      .map((particle) => `(${particle})`)
      .reduce((acc, cur) => `${acc}${cur}`, "");

    return {
      japanese: `${word}${particles}`,
      furigana: furigana != null ? `${furigana}${particles}` : null,
    };
  });
  return highlights.reduce(
    (acc, segment) => ({
      japanese: `${acc.japanese}${segment.japanese}`,
      furigana:
        segment.furigana == null
          ? `${acc.furigana}${segment.japanese}`
          : `${acc.furigana}${segment.furigana}`,
    }),
    { japanese: "", furigana: "" }
  );
};

const getQuestion = async (testableWordJoin, pg) => {
  if (["J_WORD", "KANA_WORD"].includes(testableWordJoin.question_type)) {
    return {
      type: testableWordJoin.question_type,
      image: testableWordJoin.image,
      emoji: testableWordJoin.emoji,
      text:
        testableWordJoin.question_type === "J_WORD"
          ? testableWordJoin.japanese
          : testableWordJoin.hiragana,
      furigana:
        testableWordJoin.question_type === "J_WORD"
          ? testableWordJoin.hiragana
          : null,
      // maybe change this prompt to be "Spell this word with English letters"
      prompt: null,
    };
  }

  const questionText =
    testableWordJoin.question_type === "J_SENTENCE"
      ? await parseWithHighlights(
          testableWordJoin.question_text,
          pg,
          testableWordJoin.word_id
        )
      : {
          japanese: testableWordJoin.question_text,
          furigana: testableWordJoin.question_text_fg,
        };

  return {
    type: testableWordJoin.question_type,
    image: null,
    emoji: null,
    text: (questionText || {}).japanese || testableWordJoin.question_text,
    furigana:
      (questionText || {}).furigana || testableWordJoin.question_text_fg,
    prompt: testableWordJoin.question_prompt,
  };
};

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

const getAnswer = (testableWordJoin) => {
  if (testableWordJoin.answer_type === "ROMAJI") {
    return {
      text: hiraganaToRomajiCSV(testableWordJoin.hiragana),
      type: testableWordJoin.answer_type,
    };
  }
  return {
    text: testableWordJoin.possible_answers,
    type: testableWordJoin.answer_type,
  };
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
  lesson: UserSetLessonJoinSetLessonDB | SetLessonDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const words = await pg("words").where("set_lesson_id", lesson.id);
  let hetaWords = [];
  // Only add bad words to the testable list if this is a user-set-lesson-join
  if (lesson.id === "HIRAGANA_A" && lesson.user_id != null) {
    hetaWords = await getHetaWords(
      pg,
      words.map((w) => w.id),
      // $FlowFixMe I check this above
      lesson.user_id,
      lesson.status === "COMPLETE" ? 0 : 2
    );
  }
  const lectures = await pg("lectures").where("set_lesson_id", lesson.id);
  const testables = words.concat(hetaWords).map((word) => ({
    objectId: word.id,
    objectType: "WORD",
    question: {
      type: "KANA_WORD",
      image: word.image,
      emoji: word.emoji,
      text: word.hiragana,
      prompt: null,
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
    skillLevel: lesson.skill_level,
    timeEstimate: lesson.time_estimate,
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

export const normalLessonResolver = async (
  lesson: UserSetLessonJoinSetLessonDB | SetLessonDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const dbTestables = await pg("testables")
    .where("testables.set_lesson_id", lesson.id)
    .select(["testables.*", "words.*", "testables.id as testable_id"])
    .leftJoin("words", "words.id", "=", "testables.word_id");

  const testables = dbTestables
    .map(async (testable) => {
      const contextText = await parseWithHighlights(
        testable.context_jp,
        pg,
        testable.wordId
      );
      return {
        objectId:
          testable.question_type === "J_WORD"
            ? testable.word_id
            : testable.testable_id,
        objectType: getObjectType(testable.question_type),
        question: await getQuestion(testable, pg),
        answer: getAnswer(testable),
        introduction: testable.introduction, // will be non-null iff it's a word
        context: {
          person: testable.person,
          location: testable.location,
          japanese: (contextText || {}).japanese || testable.context_jp,
          furigana: (contextText || {}).furigana || testable.context_fg,
          english: testable.context_en,
          speaker: testable.context_speaker,
        },
        orderInLesson: testable.order_in_lesson,
      };
    })
    .sort((a, b) => {
      if (a.orderInLesson < b.orderInLesson) {
        return -1;
      }
      if (a.orderInLesson > b.orderInLesson) {
        return 1;
      }
      return 0;
    });

  const lectures = await pg("lectures").where("set_lesson_id", lesson.id);
  return {
    id: lesson.id,
    title: lesson.title,
    image: lesson.image,
    skillLevel: lesson.skill_level,
    timeEstimate: lesson.time_estimate,
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
  lesson: UserSetLessonJoinSetLessonDB | SetLessonDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  switch (lesson.course_id) {
    case "HIRAGANA":
      return kanaLessonResolver(lesson, pg);
    case "KATAKANA":
      return kanaLessonResolver(lesson, pg);
    default:
      return normalLessonResolver(lesson, pg);
  }
};

export const lessonsResolver = async (
  course: CourseDB,
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  const lessons = await pg("set_lessons").where({ course_id: course.id });
  return lessons.map((lesson) => lessonResolver(lesson, pg));
};

export const availableLessonsResolver = async (
  course: UserCourseJoinCourseDB,
  userId: string,
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
      "user_set_lessons.user_id": userId,
      "user_set_lessons.status": "AVAILABLE",
    });
  return availableLessons.map((lesson) => lessonResolver(lesson, pg));
};

export const completedLessonsResolver = async (
  course: UserCourseJoinCourseDB,
  userId: string,
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
      "user_set_lessons.user_id": userId,
      "user_set_lessons.status": "COMPLETE",
    });
  return completeLessons.map((lesson) => lessonResolver(lesson, pg));
};

export const nextUnlockLessonsResolver = async (
  course: UserCourseJoinCourseDB,
  userId: string,
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
      "user_set_lessons.user_id": userId,
      "user_set_lessons.status": "AVAILABLE",
    });

  const nextUnlockLessonIds = availableLessons.reduce(
    (acc, lesson) =>
      typeof lesson.unlocks_ids === "string"
        ? acc.concat(lesson.unlocks_ids.split(","))
        : acc,
    []
  );
  const lessons = await pg("set_lessons").whereIn("id", nextUnlockLessonIds);

  return lessons.map((lesson) => lessonResolver(lesson, pg));
};
