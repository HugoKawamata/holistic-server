// @flow
import { gql } from "apollo-server-express";

const KANA_LEVEL = `
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
  enum LessonContent {
    ${KANA_LEVEL}
    OTHER
  }

  enum KanaLevel {
    ${KANA_LEVEL}
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
    SENTENCE
  }

  enum QuestionType {
    J_WORD
    J_SENTENCE
    E_WORD
    E_SENTENCE
  }

  enum AnswerType {
    ROMAJI
    HIRAGANA
    JAPANESE
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
    name: String
    email: String
    nextLesson: Lesson
    kanaLevel: KanaLevel
  }

  type Lesson {
    content: LessonContent! # How to determine what to show at the end of the lesson
    testables: [Testable!]
    titleScreen: TitleScreenInfo
    lectures: [Lecture!]
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
    question: Question!
    answer: Answer!
    introduction: String
  }

  type Question {
    type: QuestionType!
    image: String
    emoji: String
    text: String!
  }

  type Answer {
    type: AnswerType!
    text: String!
  }

  type TitleScreenInfo {
    image: String
    title: String!
  }

  input Result {
    objectId: ID
    objectType: TestableObject!
    text: String
    answers: [String]
    marks: [Mark]
  }

  type Mutation {
    addLessonResults(results: [Result]!, userId: ID!, content: LessonContent!): Boolean
  }
`;

export default typeDefs;
