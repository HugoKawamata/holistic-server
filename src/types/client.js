/* @flow */

export type ResultCT = {
  objectId: ?number,
  objectType: "WORD" | "CHARACTER" | "TESTABLE",
  text: string,
  answers: string,
  marks: Array<"CORRECT" | "INCORRECT">,
};

export type ResultsCT = {
  [key: string]: ResultCT,
};
