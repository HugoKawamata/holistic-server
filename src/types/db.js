/* @flow */
import type { CourseLessonStatus } from "./util";

export type SetLessonDB = {|
  id: string, // eg. HIRAGANA_A, HIRAGANA_KA, GMR_SUBJECT_WA
  title: string, // Shows up on the link cards
  image: string, // Shows up on the link cards
  unlocks_ids: string, // CSV separated set_lesson ids. eg. "HIRAGANA_A,GMR_SUBJECT_WA"
  course_id: string, // Parent course. eg. "HIRAGANA"
|};

export type UserSetLessonDB = {|
  user_id: number,
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
  user_id: number,
  course_id: string,
  status: CourseLessonStatus,
|};

export type UserCourseJoinCourseDB = {|
  ...CourseDB,
  ...UserCourseDB,
|};
