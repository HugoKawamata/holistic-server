/* @flow */

export type ResultCT = {
  objectId: ?number,
  objectType: "WORD" | "CHARACTER",
  text: string,
  answers: string,
  marks: Array<"CORRECT" | "INCORRECT">,
};

export type ResultsCT = {
  [key: string]: ResultCT,
};
