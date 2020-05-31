// eslint-disable-next-line flowtype/require-valid-file-annotation
import express from "express";
import { ApolloServer } from "apollo-server-express";
import session from "express-session";
import pgStore from "connect-pg-simple";
import passport from "passport";
import GoogleTokenStrategy from "passport-google-id-token";
import { v5 as uuidv5 } from "uuid";
import knex from "knex";
import {
  userResolver,
  meResolver,
  addLessonResultsResolver,
  availableCoursesResolver,
  userCourseResolver,
  nextUnlockCoursesResolver,
} from "./resolvers";
import typeDefs from "./typeDefs";

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
    (parsedToken, googleId, done) => {
      if (parsedToken) {
        pg.transaction(async (trx) => {
          const insert = pg("accounts")
            .insert({
              id: uuidv5(parsedToken.payload.email, process.env.NAMESPACE_UUID),
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
              status: "AVAILABLE",
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
              status: "AVAILABLE",
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
    me: meResolver(pg),
  },
  User: {
    availableCourses: availableCoursesResolver(pg),
    nextUnlockCourses: nextUnlockCoursesResolver(pg),
    course: userCourseResolver(pg),
  },
  Mutation: {
    addLessonResults: addLessonResultsResolver(pg),
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) =>
    console.log("req!", req.sessionStore, req.session, req.headers) || {
      session: req.session,
    },
});

const app = express();

app.use(
  session({
    store: new (pgStore(session))(),
    secret: process.env.SESSION_SECRET,
    resave: true,
    saveUninitialized: false,
    proxy: true,
  })
);
app.use((req, res, next) => {
  if (req.headers["cloudfront-forwarded-proto"]) {
    req.headers["x-forwarded-proto"] =
      req.headers["cloudfront-forwarded-proto"];
  }
  next();
});
app.use(passport.initialize());
app.use(passport.session());

app.post("/login", passport.authenticate("google-id-token"), (req, res) => {
  res.json(req.user);
});

app.post("/logout", (req, res) => {
  req.logout();
  res.json({ success: true });
});

server.applyMiddleware({ app });

app.listen({ port: 80 }, () =>
  console.log(
    `running apollo server at https://www.issei.com.au${server.graphqlPath}`
  )
);
