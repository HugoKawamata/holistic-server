import { ApolloServer, gql } from "apollo-server";
import knex from "knex";
import { userResolver } from "./src/resolvers";
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
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
  console.log(`running apollo server at ${url}`);
});
