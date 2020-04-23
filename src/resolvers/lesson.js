// @flow

export const nextLessonResolver = (pg) => {
  return (user, args) => {
    // No args given, just generate the next lesson with the defaults
    if (Object.keys(args).length < 1) {
      if (user.kana_level != "COMPLETE") {
        return getKanaLesson(user.kana_level);
      }

      return {
        content: "OTHER",
        preface: [],
        testables: [],
      };
    }
  };
};

const getKanaLesson = (kana_level) => {
  switch (kana_level) {
    case null:
      return getHiraganaALesson();
    default:
      throw new Error("Invalid kana level");
  }
};

const getHiraganaALesson = () => {
  return {
    content: "HIRAGANA_A",
    testables: [
      {
        question: {
          type: "J_WORD",
          image: null,
          text: "あお",
        },
        answer: {
          type: "ROMAJI",
          text: "a,o",
          audio: null,
        },
        notes: {
          text:
            'This word means "blue". The first letter is "a" and the second letter is "o". Make sure you listen to the pronunciation!',
        },
      },
      {
        question: {
          type: "J_WORD",
          image: null,
          text: "いえ",
        },
        answer: {
          type: "ROMAJI",
          text: "i,e",
          audio: null,
        },
        notes: {
          text:
            'This is "house". The first letter is "i" and the second letter is "e".',
        },
      },
      {
        question: {
          type: "J_WORD",
          image: null,
          text: "いいえ",
        },
        answer: {
          type: "ROMAJI",
          text: "i,i,e",
          audio: null,
        },
        notes: {
          text:
            'This word means "no". It\'s very similar to "house" isn\'t it? The only difference is you say "ii" for longer.',
        },
      },
      {
        question: {
          type: "J_WORD",
          image: null,
          text: "うえ",
        },
        answer: {
          type: "ROMAJI",
          text: "u,e",
          audio: null,
        },
        notes: {
          text:
            'This word means "up". The first letter is "u". You should already know the second letter!',
        },
      },
    ],
    preface: [
      {
        text:
          "Hiragana consists of 5 characters that represent vowel sounds (A, I, U, E, O) and 40 characters that represent a consonant-plus-a-vowel-sound (K, S, T, N, H, M, Y, ɾ, and W), as well as a single lone consonant (N).",
        image:
          "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/preface-1.png",
      },
      {
        text:
          'Because the characters represent syllables, they are always pronounced the same. Unlike in English, where "same" is pronouned with a long A sound, the Japanese "さめ" 🦈 (sa・me) is pronounced "sah-meh".',
        image:
          "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262012/lessons/hiragana-a/preface-2.png",
      },
    ],
    titleScreen: {
      title: "Hiragana Lesson 1",
      image:
        "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-a/preface-3.png",
    },
  };
};
