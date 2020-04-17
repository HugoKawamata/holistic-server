// @flow
import express from "express";
import graphqlHTTP from "express-graphql";
import graphql, { buildSchema } from "graphql";
import joinMonster from "join-monster";
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

const QueryRoot = new graphql.GraphQLObjectType({
  name: "Query",
  fields: () => ({
    hello: {
      type: graphql.GraphQLString,
      resolve: () => "Hello world!",
    },
    user: {
      type: User,
      args: { id: { type: graphql.GraphQLNonNull(graphql.GraphQLInt) } },
      where: (userTable, args, context) => `${userTable}.id = ${args.id}`,
      resolve: (parent, args, context, resolveInfo) => {
        return joinMonster.default(resolveInfo, {}, (sql) => {
          return client.query(sql);
        });
      },
    },
    users: {
      type: new graphql.GraphQLList(User),
      resolve: (parent, args, context, resolveInfo) => {
        return joinMonster.default(resolveInfo, {}, (sql) => {
          return client.query(sql);
        });
      },
    },
  }),
});

const User = new grapqhql.GraphQLObjectType({
  name: "User",
  fields: () => ({
    id: { type: graphql.GraphQLString },
    name: { type: graphql.GraphQLString },
    email: { type: graphql.GraphQLString },
  }),
});

User._typeConfig = {
  sqlTable: "accounts",
  uniqueKey: "id",
};

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
