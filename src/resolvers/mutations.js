// @flow

export const kanaLevelArray = [
  null,
  "HIRAGANA-A",
  "HIRAGANA-KA",
  "HIRAGANA-GA",
  "HIRAGANA-SA",
  "HIRAGANA-ZA",
  "HIRAGANA-TA",
  "HIRAGANA-DA",
  "HIRAGANA-NA",
  "HIRAGANA-N",
  "HIRAGANA-HA",
  "HIRAGANA-BA",
  "HIRAGANA-MA",
  "HIRAGANA-WA",
  "HIRAGANA-YA",
  "HIRAGANA-LYA",
  "HIRAGANA-RA",
  "HIRAGANA-PA",

  "KATAKANA-A",
  "KATAKANA-KA",
  "KATAKANA-GA",
  "KATAKANA-SA",
  "KATAKANA-ZA",
  "KATAKANA-TA",
  "KATAKANA-DA",
  "KATAKANA-NA",
  "KATAKANA-N",
  "KATAKANA-HA",
  "KATAKANA-BA",
  "KATAKANA-MA",
  "KATAKANA-WA",
  "KATAKANA-YA",
  "KATAKANA-LYA",
  "KATAKANA-RA",
  "KATAKANA-PA",
  "COMPLETE",
];

export const kanaLevelToIntMap = {
  // null is considered the 0th element here
  "HIRAGANA-A": 1,
  "HIRAGANA-KA": 2,
  "HIRAGANA-GA": 3,
  "HIRAGANA-SA": 4,
  "HIRAGANA-ZA": 5,
  "HIRAGANA-TA": 6,
  "HIRAGANA-DA": 7,
  "HIRAGANA-NA": 8,
  "HIRAGANA-N": 9,
  "HIRAGANA-HA": 10,
  "HIRAGANA-BA": 11,
  "HIRAGANA-MA": 12,
  "HIRAGANA-WA": 13,
  "HIRAGANA-YA": 14,
  "HIRAGANA-LYA": 15,
  "HIRAGANA-RA": 16,
  "HIRAGANA-PA": 17,

  "KATAKANA-A": 18,
  "KATAKANA-KA": 19,
  "KATAKANA-GA": 20,
  "KATAKANA-SA": 21,
  "KATAKANA-ZA": 22,
  "KATAKANA-TA": 23,
  "KATAKANA-DA": 24,
  "KATAKANA-NA": 25,
  "KATAKANA-N": 26,
  "KATAKANA-HA": 27,
  "KATAKANA-BA": 28,
  "KATAKANA-MA": 29,
  "KATAKANA-WA": 30,
  "KATAKANA-YA": 31,
  "KATAKANA-LYA": 32,
  "KATAKANA-RA": 33,
  "KATAKANA-PA": 34,
  COMPLETE: 35,
};

export const marshalInputResultsToWordResults = (results, userId, now) => {
  return results.map((result) => ({
    user_id: userId,
    word_id: result.objectId,
    answers: result.answers,
    marks: result.marks,
    created_at: now,
    proficiency: 1,
  }));
};

export const addLessonResultsResolver = (pg) => {
  return (_, { results, userId, content }) => {
    pg.transaction(async (trx) => {
      // Update kana level if applicable
      if (content !== "OTHER") {
        const newKanaLevel = content;
        await trx("accounts")
          .where({ id: userId })
          .update({ kana_level: newKanaLevel });
      }

      const wordResults = results.filter((res) => res.objectType === "WORD");
      console.log(wordResults);

      const marshalledWordResults = marshalInputResultsToWordResults(
        wordResults,
        userId,
        pg.fn.now()
      );
      console.log(marshalledWordResults);

      const wordResultIds = await trx("word_results").insert(
        [marshalledWordResults],
        ["id"]
      );
      console.log(wordResultIds);

      trx("user_words").insert(
        wordResults.map((res, i) => ({
          user_id: userId,
          word_id: res.objectId,
          results_ids: [wordResultIds[i]],
          proficiency: 1,
        }))
      );
    });

    return true;
  };
};
