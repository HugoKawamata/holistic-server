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
    question: Question!
    answer: Answer!
    notes: TestableNote
  }

  type Question {
    type: QuestionType!
    image: String!
    text: String!
  }

  type Answer {
    type: AnswerType!
    image: String!
    text: String!
  }

  type TestableNote {
    text: String!
  }

  type TitleScreenInfo {
    image: String
    title: String!
  }
`;

export default typeDefs;
