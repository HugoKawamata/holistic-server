// @flow
import { gql } from "apollo-server";

export const typeDefs = gql`
  enum LessonContentType {
    HIRAGANA_A
    HIRAGANA_KA
    HIRAGANA_SA
    HIRAGANA_TA
    HIRAGANA_NA
    HIRAGANA_HA
    HIRAGANA_MA
    HIRAGANA_YA
    HIRAGANA_RA
    HIRAGANA_WA
    KATAKANA_A
    KATAKANA_KA
    KATAKANA_SA
    KATAKANA_TA
    KATAKANA_NA
    KATAKANA_HA
    KATAKANA_MA
    KATAKANA_YA
    KATAKANA_RA
    KATAKANA_WA
    ADVANCED
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
    user(id: ID!): User
  }

  type User {
    id: ID
    name: String
    email: String
    nextLesson: Lesson
  }

  type Lesson {
    contentType: LessonContentType # How to determine what to show at the end of the lesson
    preface: [LessonPreface]
    testables: [Testable]
  }

  type LessonPreface {
    text: String
    image: String
  }

  type Testable {
    question: Question
    answer: Answer
    notes: TestableNote
  }

  type Question {
    type: QuestionType
    image: String
    text: String
  }

  type Answer {
    type: AnswerType
    image: String
    text: String
  }

  type TestableNote {
    text: String
  }
`;

export default typeDefs;
