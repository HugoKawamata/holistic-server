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
      current = `${hiragana[hiragana.length - 1]}${current}`;
      splitQuestion = [hiraganaRomajiMap[current], ...splitQuestion];
    }
  }
  return splitQuestion.reduce((csv, kana) => csv + "," + kana);
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
    case "HIRAGANA_DA":
      return getHiraganaLesson("HIRAGANA_TA", [29, 30, 31], user, pg);
    case "HIRAGANA_NA":
      return getHiraganaLesson("HIRAGANA_DA", [32, 33, 34, 35], user, pg);
    case "HIRAGANA_N":
      return getHiraganaLesson("HIRAGANA_NA", [36, 37, 38], user, pg);
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
  // If the worst words are above a certain threshold, just don't include them
  return hetaWords
    .filter((word) => word.proficiency < 0.9)
    .map((word) => ({
      id: word.id,
      image: word.image,
      emoji: word.emoji,
      hiragana: word.hiragana,
      // No introduction for heta words
    }));
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
