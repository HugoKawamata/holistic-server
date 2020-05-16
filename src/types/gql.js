/* @flow */
import type {
  CourseLessonStatus,
  TestableObject,
  LecturePosition,
  QuestionType,
  AnswerType,
} from "./util";

export type AnswerGQL = {|
  type: AnswerType,
  text: string,
|};

export type QuestionGQL = {|
  type: QuestionType,
  image: string,
  emoji: string,
  text: string,
|};

export type TestableGQL = {|
  objectId: number,
  objectType: TestableObject,
  question: QuestionGQL,
  answer: AnswerGQL,
  introduction: string,
|};

export type LectureGQL = {|
  title: string,
  text: string,
  position: LecturePosition,
  image: string,
|};

export type LessonGQL = {|
  id: string,
  testables: Array<TestableGQL>,
  title: string,
  image: string,
  lectures: Array<LectureGQL>,
|};

export type CourseGQL = {|
  id: string,
  title: string,
  availableLessons: [LessonGQL],
  completedLessons: [LessonGQL],
  status: CourseLessonStatus,
|};

export type UserGQL = {|
  id: number,
  name: string,
  email: string,
  availableCourses: Array<CourseGQL>,
  course: CourseGQL,
|};
