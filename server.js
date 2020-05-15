import express from "express";
import { ApolloServer, gql } from "apollo-server-express";
import session from "express-session";
import passport from "passport";
import GoogleTokenStrategy from "passport-google-id-token";
import knex from "knex";
import {
  userResolver,
  meResolver,
  nextLessonResolver,
  addLessonResultsResolver,
  availableCoursesResolver,
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

          const user = await pg("accounts")
            .where("email", parsedToken.payload.email)
            .transacting(trx)
            .then((users) => users[0]);

          console.log("created and found user", user);

          const initCourses = pg("user_courses")
            .insert({
              user_id: user.id,
              course_id: "HIRAGANA",
              status: "IN_PROGRESS",
            })
            .transacting(trx)
            .toString();

          await pg
            .raw(`${initCourses} ON CONFLICT (user_id, course_id) DO NOTHING`)
            .transacting(trx);

          const initLessons = pg("user_set_lessons")
            .insert({
              user_id: user.id,
              set_lesson_id: "HIRAGANA_A",
              status: "IN_PROGRESS",
            })
            .transacting(trx)
            .toString();

          await pg
            .raw(
              `${initLessons} ON CONFLICT (user_id, set_lesson_id) DO NOTHING`
            )
            .transacting(trx);
        });

        return done(null, {
          email: parsedToken.payload.email,
          name: parsedToken.payload.name,
          picture: parsedToken.payload.picture,
          google_id: parsedToken.payload.googleId,
        });
      } else {
        console.log("❌ Parsed token invalid");
        return done(null, false);
      }
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
    me: meResolver(pg),
  },
  User: {
    availableCourses: availableCoursesResolver(pg),
  },
  Mutation: {
    addLessonResults: addLessonResultsResolver(pg),
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => ({ session: req.session }),
});

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

app.post("/login", passport.authenticate("google-id-token"), (req, res) => {
  console.log("auth complete, req:", req, "res:", res);
  res.json(req.user);
});

server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(
    `running apollo server at http://localhost:4000${server.graphqlPath}`
  )
);
