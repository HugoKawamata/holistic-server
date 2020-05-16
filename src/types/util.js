/* @flow */

export type CourseLessonStatus = "COMPLETE" | "AVAILABLE";

export type LecturePosition =
  | "PRETEST" // Appears before lesson title screen
  | "BEFORE_SECOND" // Appears just before the second question is presented
  | "BEFORE_THIRD" // Appears just before the third question is presented
  | "BEFORE_FOURTH" // Appears just before the fourth question is presented
  | "BEFORE_FIFTH" // Appears just before the fifth question is presented
  | "BEFORE_RESULTS"; // Appears just before the results are presented

export type TestableObject = "CHARACTER" | "WORD" | "SENTENCE";

export type QuestionType = "J_WORD" | "J_SENTENCE" | "E_WORD" | "E_SENTENCE";

export type AnswerType = "ROMAJI" | "HIRAGANA" | "JAPANESE" | "MC";
