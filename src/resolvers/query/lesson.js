export const romajiHiraganaMap = {
  a: "あ",
  i: "い",
  u: "う",
  e: "え",
  o: "お",
  ka: "か",
  ki: "き",
  ku: "く",
  ke: "け",
  ko: "こ",
  ga: "が",
  gi: "ぎ",
  gu: "ぐ",
  ge: "げ",
  go: "ご",
  sa: "さ",
  shi: "し",
  su: "す",
  se: "せ",
  so: "そ",
  za: "ざ",
  ji: "じ",
  zu: "ず",
  ze: "ぜ",
  zo: "ぞ",
  ta: "た",
  chi: "ち",
  tsu: "つ",
  te: "て",
  to: "と",
  da: "だ",
  dji: "ぢ",
  dzu: "づ",
  de: "で",
  do: "ど",
  na: "な",
  ni: "に",
  nu: "ぬ",
  ne: "ね",
  no: "の",
  ha: "は",
  hi: "ひ",
  fu: "ふ",
  he: "へ",
  ho: "ほ",
  ba: "ば",
  bi: "び",
  bu: "ぶ",
  be: "べ",
  bo: "ぼ",
  pa: "ぱ",
  pi: "ぴ",
  pu: "ぷ",
  pe: "ぺ",
  po: "ぽ",
  ma: "ま",
  mi: "み",
  mu: "む",
  me: "め",
  mo: "も",
  ya: "や",
  yu: "ゆ",
  yo: "よ",
  ra: "ら",
  ri: "り",
  ru: "る",
  re: "れ",
  ro: "ろ",
  wa: "わ",
  wo: "を",
  n: "ん",
  kya: "きゃ",
  kyu: "きゅ",
  kyo: "きょ",
  gya: "ぎゃ",
  gyu: "ぎゅ",
  gyo: "ぎょ",
  sha: "しゃ",
  shu: "しゅ",
  sho: "しょ",
  ja: "じゃ",
  ju: "じゅ",
  jo: "じょ",
  cha: "ちゃ",
  chu: "ちゅ",
  cho: "ちょ",
  nya: "にゃ",
  nyu: "にゅ",
  nyo: "にょ",
  hya: "ひゃ",
  hyu: "ひゅ",
  hyo: "ひょ",
  bya: "びゃ",
  byu: "びゅ",
  byo: "びょ",
  pya: "ぴゃ",
  pyu: "ぴゅ",
  pyo: "ぴょ",
  mya: "みゃ",
  myu: "みゅ",
  myo: "みょ",
  rya: "りゃ",
  ryu: "りゅ",
  ryo: "りょ",
};

export const hiraganaRomajiMap = {
  あ: "a",
  い: "i",
  う: "u",
  え: "e",
  お: "o",
  か: "ka",
  き: "ki",
  く: "ku",
  け: "ke",
  こ: "ko",
  が: "ga",
  ぎ: "gi",
  ぐ: "gu",
  げ: "ge",
  ご: "go",
  さ: "sa",
  し: "shi",
  す: "su",
  せ: "se",
  そ: "so",
  ざ: "za",
  じ: "ji",
  ず: "zu",
  ぜ: "ze",
  ぞ: "zo",
  た: "ta",
  ち: "chi",
  つ: "tsu",
  て: "te",
  と: "to",
  だ: "da",
  ぢ: "dji",
  づ: "dzu",
  で: "de",
  ど: "do",
  な: "na",
  に: "ni",
  ぬ: "nu",
  ね: "ne",
  の: "no",
  は: "ha",
  ひ: "hi",
  ふ: "fu",
  へ: "he",
  ほ: "ho",
  ば: "ba",
  び: "bi",
  ぶ: "bu",
  べ: "be",
  ぼ: "bo",
  ぱ: "pa",
  ぴ: "pi",
  ぷ: "pu",
  ぺ: "pe",
  ぽ: "po",
  ま: "ma",
  み: "mi",
  む: "mu",
  め: "me",
  も: "mo",
  や: "ya",
  ゆ: "yu",
  よ: "yo",
  ら: "ra",
  り: "ri",
  る: "ru",
  れ: "re",
  ろ: "ro",
  わ: "wa",
  を: "wo",
  ん: "n",
  きゃ: "kya",
  きゅ: "kyu",
  きょ: "kyo",
  ぎゃ: "gya",
  ぎゅ: "gyu",
  ぎょ: "gyo",
  しゃ: "sha",
  しゅ: "shu",
  しょ: "sho",
  じゃ: "ja",
  じゅ: "ju",
  じょ: "jo",
  ちゃ: "cha",
  ちゅ: "chu",
  ちょ: "cho",
  にゃ: "nya",
  にゅ: "nyu",
  にょ: "nyo",
  ひゃ: "hya",
  ひゅ: "hyu",
  ひょ: "hyo",
  びゃ: "bya",
  びゅ: "byu",
  びょ: "byo",
  ぴゃ: "pya",
  ぴゅ: "pyu",
  ぴょ: "pyo",
  みゃ: "mya",
  みゅ: "myu",
  みょ: "myo",
  りゃ: "rya",
  りゅ: "ryu",
  りょ: "ryo",
};

const hiraganaToRomajiCSV = (hiragana) => {
  let splitQuestion = [];

  // We have to go backwards due to lya/lyu/lyo
  while (hiragana.length > 0) {
    let current = hiragana[hiragana.length - 1];
    hiragana = hiragana.slice(0, hiragana.length - 1);
    if (Object.keys(hiraganaRomajiMap).includes(current)) {
      splitQuestion = [current, ...splitQuestion];
    } else {
      current = `${hiragana[hiragana.length - 1]}${current}`;
      splitQuestion = [current, ...splitQuestion];
    }
  }
  return splitQuestion;
};

export const nextLessonResolver = (pg) => {
  return (user, args) => {
    // No args given, just generate the next lesson with the defaults
    if (Object.keys(args).length < 1) {
      if (user.kana_level != "COMPLETE") {
        return getKanaLesson(user.kana_level, pg);
      }

      return {
        content: "OTHER",
        preface: [],
        testables: [],
      };
    }
  };
};

const getKanaLesson = (kana_level, pg) => {
  switch (kana_level) {
    case null:
      return getHiraganaALesson(pg);
    case "HIRAGANA_A":
      return getHiraganaALesson(pg);
    default:
      throw new Error("Invalid kana level");
  }
};

const getHiraganaALesson = async (pg) => {
  const aWords = await pg("words").whereIn("id", [1, 2, 3, 4]);
  console.log("AWORDS", aWords);
  const testables = aWords.map((word) => ({
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
  console.log("TESTABLES", testables);
  return {
    content: "HIRAGANA_A",
    testables,
  };
};

// return {
//   content: "HIRAGANA_A",
//   testables: [
//     {
//       objectId: 1,
//       objectType: "WORD",
//       question: {
//         type: "J_WORD",
//         image: null,
//         emoji: "🔵",
//         text: "あお",
//       },
//       answer: {
//         type: "ROMAJI",
//         text: "a,o",
//       },
//       notes: {
//         text:
//           'This word means "blue". The first letter is "a" and the second letter is "o". Make sure you listen to the pronunciation!',
//       },
//     },
//     {
//       objectId: 2,
//       objectType: "WORD",
//       question: {
//         type: "J_WORD",
//         image: null,
//         emoji: "🏠",
//         text: "いえ",
//       },
//       answer: {
//         type: "ROMAJI",
//         text: "i,e",
//       },
//       notes: {
//         text:
//           'This is "house". The first letter is "i" and the second letter is "e".',
//       },
//     },
//     {
//       objectId: 3,
//       objectType: "WORD",
//       question: {
//         type: "J_WORD",
//         image: null,
//         emoji: "🙅‍♀️",
//         text: "いいえ",
//       },
//       answer: {
//         type: "ROMAJI",
//         text: "i,i,e",
//       },
//       notes: {
//         text:
//           'This word means "no". It\'s very similar to "house" isn\'t it? The only difference is you say "ii" for longer.',
//       },
//     },
//     {
//       objectId: 4,
//       objectType: "WORD",
//       question: {
//         type: "J_WORD",
//         image: null,
//         emoji: "⬆️",
//         text: "うえ",
//       },
//       answer: {
//         type: "ROMAJI",
//         text: "u,e",
//       },
//       notes: {
//         text:
//           'This word means "up". The first letter is "u". You should already know the second letter!',
//       },
//     },
//   ],
//   preface: [
//     {
//       text:
//         "Hiragana consists of 5 characters that represent vowel sounds (A, I, U, E, O) and 40 characters that represent a consonant-plus-a-vowel-sound (K, S, T, N, H, M, Y, ɾ, and W), as well as a single lone consonant (N).",
//       image:
//         "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/preface-1.png",
//     },
//     {
//       text:
//         'Because the characters represent syllables, they are always pronounced the same. Unlike in English, where "same" is pronouned with a long A sound, the Japanese "さめ" 🦈 (sa・me) is pronounced "sah-meh".',
//       image:
//         "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262012/lessons/hiragana-a/preface-2.png",
//     },
//   ],
//   titleScreen: {
//     title: "Hiragana Lesson 1",
//     image:
//       "https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-a/preface-3.png",
//   },
// };
