import { ApolloServer, gql } from "apollo-server";
import knex from "knex";

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

// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.
const typeDefs = gql`
  # Comments in GraphQL strings (such as this one) start with the hash (#) symbol.

  type User {
    id: ID
    name: String
    email: String
  }

  # The "Query" type is special: it lists all of the available queries that
  # clients can execute, along with the return type for each. In this
  # case, the "books" query returns an array of zero or more Books (defined above).
  type Query {
    hello: String
    user(id: ID!): User
    users: [User]
  }
`;

const resolvers = {
  Query: {
    hello: () => "hello",
    user: async (obj, args, context, info) =>
      await pg("accounts")
        .where("id", args.id)
        .then((users) => users[0]),
    users: () => [],
  },
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
  console.log(`running apollo server at ${url}`);
});
