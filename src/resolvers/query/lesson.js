import { hiraganaRomajiMap, romajiHiraganaMap, kanaLevelArray } from "../util";

const hiraganaToRomajiCSV = (hiragana) => {
  let splitQuestion = [];

  // We have to go backwards due to lya/lyu/lyo/sokuon
  while (hiragana.length > 0) {
    let current = hiragana[hiragana.length - 1];
    hiragana = hiragana.slice(0, hiragana.length - 1);
    if (Object.keys(hiraganaRomajiMap).includes(current)) {
      splitQuestion = [hiraganaRomajiMap[current], ...splitQuestion];
    } else if (current === "っ") {
      // Strip the first character off the most recent romaji
      splitQuestion = [splitQuestion[0][0], ...splitQuestion];
    } else {
      // It was a lya/lyu/lyo
      current = `${hiragana[hiragana.length - 1]}${current}`;
      // Remove the next hiragana character
      hiragana = hiragana.slice(0, hiragana.length - 1);
      splitQuestion = [hiraganaRomajiMap[current], ...splitQuestion];
    }
  }
  return splitQuestion.reduce((csv, kana) => csv + "," + kana);
};

const getKanaLesson = (user, pg) => {
  switch (user.kana_level) {
    case null:
      return getHiraganaLesson("HIRAGANA_A", [1, 2, 3, 4], user, pg);
    case "HIRAGANA_A":
      return getHiraganaLesson("HIRAGANA_KA", [5, 6, 7, 8], user, pg);
    case "HIRAGANA_KA":
      return getHiraganaLesson("HIRAGANA_GA", [9, 10, 11, 12, 13], user, pg);
    case "HIRAGANA_GA":
      return getHiraganaLesson("HIRAGANA_SA", [14, 15, 16, 17, 18], user, pg);
    case "HIRAGANA_SA":
      return getHiraganaLesson("HIRAGANA_ZA", [19, 20, 21, 22, 23], user, pg);
    case "HIRAGANA_ZA":
      return getHiraganaLesson("HIRAGANA_TA", [24, 25, 26, 27, 28], user, pg);
    case "HIRAGANA_TA":
      return getHiraganaLesson("HIRAGANA_DA", [29, 30, 31], user, pg);
    case "HIRAGANA_DA":
      return getHiraganaLesson("HIRAGANA_NA", [32, 33, 34, 35], user, pg);
    case "HIRAGANA_NA":
      return getHiraganaLesson("HIRAGANA_N", [36, 37, 38], user, pg);
    case "HIRAGANA_N":
      return getHiraganaLesson("HIRAGANA_HA", [39, 40, 41, 42, 43], user, pg);
    case "HIRAGANA_HA":
      return getHiraganaLesson("HIRAGANA_BA", [44, 45, 46, 47, 48], user, pg);
    case "HIRAGANA_BA":
      return getHiraganaLesson("HIRAGANA_MA", [49, 50, 51, 52, 53], user, pg);
    case "HIRAGANA_MA":
      return getHiraganaLesson("HIRAGANA_WA", [54, 55, 73], user, pg);
    case "HIRAGANA_WA":
      return getHiraganaLesson("HIRAGANA_YA", [56, 57, 58], user, pg);
    case "HIRAGANA_YA":
      return getHiraganaLesson("HIRAGANA_LYA", [59, 60, 61, 62], user, pg);
    case "HIRAGANA_LYA":
      return getHiraganaLesson("HIRAGANA_RA", [63, 64, 65, 66, 67], user, pg);
    case "HIRAGANA_RA":
      return getHiraganaLesson("HIRAGANA_PA", [68, 69, 70, 71, 72], user, pg);
    default:
      throw new Error("Invalid kana level");
  }
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

const getHiraganaLesson = async (content, wordIds, user, pg) => {
  const words = await pg("words").whereIn("id", wordIds);
  const hetaWords =
    content == "HIRAGANA_A" ? [] : await getHetaWords(pg, wordIds, user.id);
  const lesson = await pg("set_lessons")
    .where("content", content)
    .then((lessons) => lessons[0]);
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
    content: lesson.content,
    titleScreen: {
      title: lesson.title,
      image: lesson.titleScreenImage,
    },
    lectures: lectures.sort((a, b) => {
      if (a.id < b.id) {
        return -1;
      } else if (a.id > b.id) {
        return 1;
      } else {
        return 0;
      }
    }),
    testables,
  };
};

export const nextLessonResolver = (pg) => {
  return (user, args) => {
    // No args given, just generate the next lesson with the defaults
    if (Object.keys(args).length < 1) {
      if (user.kana_level != "COMPLETE") {
        return getKanaLesson(user, pg);
      }

      return {
        content: "OTHER",
        lectures: [],
        testables: [],
      };
    }
  };
};

export const kanaLessonResolver = async (lesson, pg) => {
  const words = await pg("words").where("lesson_id", lesson.id);
  const hetaWords =
    lesson.id == "HIRAGANA_A"
      ? []
      : await getHetaWords(
          pg,
          words.map((w) => w.id),
          user.id
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
    content: lesson.content,
    titleScreen: {
      title: lesson.title,
      image: lesson.titleScreenImage,
    },
    lectures: lectures.sort((a, b) => {
      if (a.id < b.id) {
        return -1;
      } else if (a.id > b.id) {
        return 1;
      } else {
        return 0;
      }
    }),
    testables,
  };
};

export const lessonResolver = async (lesson, pg) => {
  switch (lesson.course_id) {
    case "HIRAGANA":
      return kanaLessonResolver(lesson, pg);
    case "KATAKANA":
      return kanaLessonResolver(lesson, pg);
    default:
      return null;
  }
};

export const availableLessonsResolver = async (course, pg) => {
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
