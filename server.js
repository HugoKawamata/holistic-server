import express from "express";
import { ApolloServer, gql } from "apollo-server-express";
import session from "express-session";
import passport from "passport";
import knex from "knex";
import {
  userResolver,
  nextLessonResolver,
  addLessonResultsResolver,
} from "./src/resolvers";
import typeDefs from "./src/typeDefs";

require("./src/auth");
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

app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: true,
    saveUninitialized: true,
  })
);

app.use(passport.initialize());
app.use(passport.session());

app.post(
  "/login",
  passport.authenticate("google-id-token", (req, res) => {
    console.log("auth complete, req:", req, "res:", res);
  })
);

server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(
    `running apollo server at http://localhost:4000${server.graphqlPath}`
  )
);
