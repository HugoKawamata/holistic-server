/* @flow */
import { gql } from "apollo-server-express";

export const KANA_LESSON_IDS = `
  HIRAGANA_A
  HIRAGANA_KA
  HIRAGANA_GA
  HIRAGANA_SA
  HIRAGANA_ZA
  HIRAGANA_TA
  HIRAGANA_DA
  HIRAGANA_NA
  HIRAGANA_N
  HIRAGANA_HA
  HIRAGANA_BA
  HIRAGANA_MA
  HIRAGANA_WA
  HIRAGANA_YA
  HIRAGANA_LYA
  HIRAGANA_RA
  HIRAGANA_PA
  KATAKANA_A
  KATAKANA_KA
  KATAKANA_GA
  KATAKANA_SA
  KATAKANA_ZA
  KATAKANA_TA
  KATAKANA_DA
  KATAKANA_NA
  KATAKANA_N
  KATAKANA_HA
  KATAKANA_BA
  KATAKANA_MA
  KATAKANA_WA
  KATAKANA_YA
  KATAKANA_LYA
  KATAKANA_RA
  KATAKANA_PA
`;

export const typeDefs = gql`
  enum CourseLessonStatus {
    AVAILABLE
    COMPLETE
  }

  enum LecturePosition {
    PRETEST # Appears before lesson title screen
    BEFORE_SECOND # Appears just before the second question is presented
    BEFORE_THIRD # Appears just before the third question is presented
    BEFORE_FOURTH # Appears just before the fourth question is presented
    BEFORE_FIFTH # Appears just before the fifth question is presented
    BEFORE_RESULTS # Appears just before the results are presented
  }

  enum TestableObject {
    CHARACTER
    WORD
    TESTABLE
  }

  enum QuestionType {
    KANA_WORD
    J_WORD
    J_SENTENCE
    E_WORD
    E_SENTENCE
  }

  enum AnswerType {
    ROMAJI
    HIRAGANA
    JAPANESE
    ENGLISH
    MC
  }

  enum Mark {
    CORRECT
    INCORRECT
  }

  type Query {
    user(email: String!): User
    me: User
  }

  type User {
    id: ID!
    picture: String!
    name: String!
    email: String!
    gender: String
    availableCourses: [Course]
    completedCourses: [Course]
    nextUnlockCourses: [Course]
    course(id: String!): Course
    createdAt: Float
    splots: Splots
  }

  type Course {
    id: String!
    title: String!
    availableLessons: [Lesson]
    completedLessons: [Lesson]
    nextUnlockLessons: [Lesson]
    unavailableLessons: [Lesson]
    learnedWords: [Word]
    lessons: [Lesson]
    status: CourseLessonStatus
  }

  type Lesson {
    id: String! # How to determine what to show at the end of the lesson
    testables: [Testable!]
    title: String!
    image: String
    lectures: [Lecture!]
    skillLevel: String # eg. "Beginner", "Intermediate", "Advanced"
    timeEstimate: Int # In seconds
  }

  type Lecture {
    title: String
    text: String!
    position: LecturePosition!
    image: String
  }

  type Testable {
    objectId: ID!
    objectType: TestableObject!
    context: Context
    question: Question!
    answer: Answer!
    displayAnswer: DisplayAnswer
    introduction: String
    wordId: Int
    orderInLesson: Int
  }

  type Context {
    person: String # conversation partner
    location: String
    speaker: String # name of speaker (plus details)
    japanese: String
    furigana: String
    english: String
  }

  type Question {
    type: QuestionType!
    image: String
    emoji: String
    text: String!
    furigana: String
    prompt: String
  }

  type Answer {
    type: AnswerType!
    text: String!
  }

  # The answer to be displayed if user gets it wrong
  type DisplayAnswer {
    text: String!
    furigana: String
  }

  type Splots {
    me: String
    meFuri: String
    fname: String
  }

  type Word {
    id: ID
    japanese: String
    hiragana: String
    english: String
    emoji: String
  }

  input Result {
    objectId: ID
    objectType: TestableObject!
    text: String
    answers: [String]
    marks: [Mark]
  }

  type Mutation {
    sendGender(userEmail: String!, gender: String!): Boolean
    addLessonResults(
      results: [Result]!
      userId: ID!
      setLessonId: String!
    ): Boolean
  }
`;

export default typeDefs;
