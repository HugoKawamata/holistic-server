import express from "express";
import { ApolloServer, gql } from "apollo-server-express";
import knex from "knex";
import {
  userResolver,
  nextLessonResolver,
  addLessonResultsResolver,
} from "./src/resolvers";
import typeDefs from "./src/typeDefs";

require("dotenv").config();

const pg = knex({
  client: "pg",
  connection: {
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: process.env.PGPORT,
  },
});

const resolvers = {
  Query: {
    user: userResolver(pg),
  },
  User: {
    nextLesson: nextLessonResolver(pg),
  },
  Mutation: {
    addLessonResults: addLessonResultsResolver(pg),
  },
};

const server = new ApolloServer({ typeDefs, resolvers });

const app = express();
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`running apollo server at ${url}`)
);
