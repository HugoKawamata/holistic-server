/* @flow */
import type { Mark, CourseLessonStatus } from "./util";

export type CharacterDB = {|
  id: number,
  character: string,
  type: "HIRAGANA" | "KATAKANA" | "KANJI",
  readings: Array<string>,
|};

export type CharacterResultDB = {|
  id: number,
  created_at: mixed,
  answers: string, // Comma separated
  marks: Array<Mark>,
  user_id: string,
  character_id: number,
|};

export type WordResultDB = {|
  id: number,
  created_at: mixed,
  answers: string, // Comma separated
  marks: Array<Mark>,
  user_id: string,
  word_id: number,
|};

export type SetLessonDB = {|
  id: string, // eg. HIRAGANA_A, HIRAGANA_KA, GMR_SUBJECT_WA
  title: string, // Shows up on the link cards
  image: string, // Shows up on the link cards
  unlocks_ids: string, // CSV separated set_lesson ids. eg. "HIRAGANA_A,GMR_SUBJECT_WA"
  course_id: string, // Parent course. eg. "HIRAGANA"
  skill_level: string, // eg. "Beginner", "Intermediate"
  time_estimate: number, // In seconds
|};

export type UserSetLessonDB = {|
  user_id: string,
  set_lesson_id: string,
  status: CourseLessonStatus,
|};

export type UserSetLessonJoinSetLessonDB = {|
  ...SetLessonDB,
  ...UserSetLessonDB,
|};

export type CourseDB = {|
  id: string, // eg. HIRAGANA
  title: string, // Shows up above link cards
  unlocks_ids: string, // CSV separated set_lesson ids. eg. "KATAKANA,GRAMMAR_1"
|};

export type UserCourseDB = {|
  user_id: string,
  course_id: string,
  status: CourseLessonStatus,
|};

export type UserDB = {|
  id: string,
  name: string,
  email: string,
  created_at: number,
  last_login: ?number,
  google_id: ?string,
  picture: ?string,
  gender: ?string, // "M", "F", "X", null
|};

export type UserCourseJoinCourseDB = {|
  ...CourseDB,
  ...UserCourseDB,
|};
