import express from "express";
import { ApolloServer, gql } from "apollo-server-express";
import session from "express-session";
import passport from "passport";
import GoogleTokenStrategy from "passport-google-id-token";
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

passport.use(
  new GoogleTokenStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID_IOS,
    },
    function (parsedToken, googleId, done) {
      if (parsedToken) {
        console.log("✅ Parsed token valid");
        pg.transaction(async (trx) => {
          const insert = pg("accounts")
            .insert({
              email: parsedToken.payload.email,
              name: parsedToken.payload.name,
              picture: parsedToken.payload.picture,
              google_id: parsedToken.payload.googleId,
              created_at: pg.fn.now(),
              last_login: pg.fn.now(),
            })
            .transacting(trx)
            .toString();

          await pg
            .raw(
              `${insert} ON CONFLICT (email) DO UPDATE SET last_login = EXCLUDED.last_login`
            )
            .transacting(trx);

          const dbUser = await pg("accounts")
            .where("email", parsedToken.payload.email)
            .then((users) => users[0])
            .transacting(trx);

          console.log("✅ Got db user", dbUser);

          return done(null, dbUser);
        });
      }

      console.log("❌ Parsed token invalid");
      return done(null, false);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
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
