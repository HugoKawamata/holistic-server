// @flow
import { gql } from "apollo-server";

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
  }

  type User {
    id: ID!
    name: String
    email: String
    nextLesson: Lesson
  }

  type Lesson {
    content: LessonContent! # How to determine what to show at the end of the lesson
    preface: [LessonPreface!]
    testables: [Testable!]
    titleScreen: TitleScreenInfo
  }

  type LessonPreface {
    text: String!
    image: String
  }

  type Testable {
    objectId: ID!
    objectType: TestableObject!
    question: Question!
    answer: Answer!
    notes: TestableNote
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

  type TestableNote {
    text: String!
  }

  type TitleScreenInfo {
    image: String
    title: String!
  }

  type Result {
    objectId: ID!
    objectType: TestableObject!
    answers: [String]
    marks: [Mark]
  }

  type Mutation {
    addLessonResults(results: [Result])
  }
`;

export default typeDefs;
