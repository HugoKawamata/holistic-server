// @flow

export const kanaLevelArray = [
  null,
  "hiragana-a",
  "hiragana-ka",
  "hiragana-ga",
  "hiragana-sa",
  "hiragana-za",
  "hiragana-ta",
  "hiragana-da",
  "hiragana-na",
  "hiragana-n",
  "hiragana-ha",
  "hiragana-ba",
  "hiragana-ma",
  "hiragana-wa",
  "hiragana-ya",
  "hiragana-lya",
  "hiragana-ra",
  "hiragana-pa",

  "katakana-a",
  "katakana-ka",
  "katakana-ga",
  "katakana-sa",
  "katakana-za",
  "katakana-ta",
  "katakana-da",
  "katakana-na",
  "katakana-n",
  "katakana-ha",
  "katakana-ba",
  "katakana-ma",
  "katakana-wa",
  "katakana-ya",
  "katakana-lya",
  "katakana-ra",
  "katakana-pa",
  "complete",
];

export const kanaLevelToIntMap = {
  // null is considered the 0th element here
  "hiragana-a": 1,
  "hiragana-ka": 2,
  "hiragana-ga": 3,
  "hiragana-sa": 4,
  "hiragana-za": 5,
  "hiragana-ta": 6,
  "hiragana-da": 7,
  "hiragana-na": 8,
  "hiragana-n": 9,
  "hiragana-ha": 10,
  "hiragana-ba": 11,
  "hiragana-ma": 12,
  "hiragana-wa": 13,
  "hiragana-ya": 14,
  "hiragana-lya": 15,
  "hiragana-ra": 16,
  "hiragana-pa": 17,

  "katakana-a": 18,
  "katakana-ka": 19,
  "katakana-ga": 20,
  "katakana-sa": 21,
  "katakana-za": 22,
  "katakana-ta": 23,
  "katakana-da": 24,
  "katakana-na": 25,
  "katakana-n": 26,
  "katakana-ha": 27,
  "katakana-ba": 28,
  "katakana-ma": 29,
  "katakana-wa": 30,
  "katakana-ya": 31,
  "katakana-lya": 32,
  "katakana-ra": 33,
  "katakana-pa": 34,
  complete: 35,
};

export const addLessonResultsResolver = (pg) => {
  return (_, { results, userId, content }) => {
    pg.transaction(async (trx) => {
      // Update kana level if applicable
      if (content !== "OTHER") {
        const newKanaLevel = kanaLevelArray[kanaLevelToIntMap[content] + 1];
        await trx("user")
          .where({ id: userId })
          .update({ kana_level: newKanaLevel });
      }

      const wordResults = results.filter((res) => res.type === "WORD");
      console.log(wordResults);

      const wordResultIds = await trx("word_results").insert(
        [wordResults],
        ["id"]
      );
      console.log(wordResultIds);

      trx("userWord").insert(
        wordResults.map((res, i) => ({
          userId: userId,
          wordId: res.objectId,
          results: wordResultIds[i],
          proficiencyCache: 1,
        }))
      );
    });

    return true;
  };
};
