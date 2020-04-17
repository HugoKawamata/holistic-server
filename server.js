// @flow
import express from "express";
import graphqlHTTP from "express-graphql";
import graphql, { buildSchema } from "graphql";
import { Pool, Client } from "pg";

require("dotenv").config();

const pool = new Pool({
  user: process.env.PGUSER,
  host: process.env.PGHOST,
  database: process.env.PGDATABASE,
  password: process.env.PGPASSWORD,
  port: process.env.PGPORT,
});

const client = new Client({
  user: process.env.PGUSER,
  host: process.env.PGHOST,
  database: process.env.PGDATABASE,
  password: process.env.PGPASSWORD,
  port: process.env.PGPORT,
});

// Construct a schema, using GraphQL schema language
const schema = buildSchema(`
  type Query {
    hello: String
    now: String
  }
`);

// The root provides a resolver function for each API endpoint
const root = {
  hello: () => "Hello world!",
  now: async () => {
    let time;
    await pool.query("SELECT NOW()", (err, res) => {
      console.log(err, res);
      if (res) {
        [time] = res.rows[0].now;
      }
      pool.end();
    });
    return time;
  },
};

const QueryRoot = new graphql.GraphQLObjectType({
  name: "Query",
  fields: () => ({
    hello: {
      type: graphql.GraphQLString,
      resolve: () => "Hello world!",
    },
  }),
});

const schema = new graphql.GraphQLSchema({ query: QueryRoot });

const app = express();
app.use(
  "/graphql",
  graphqlHTTP({
    schema,
    graphiql: true,
  })
);
app.listen(4000);
console.log("Running a GraphQL API server at http://localhost:4000/graphql");
