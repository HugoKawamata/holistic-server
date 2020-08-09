// eslint-disable-next-line flowtype/require-valid-file-annotation
import path from "path";
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
  sendGenderResolver,
  availableCoursesResolver,
  userCourseResolver,
  nextUnlockCoursesResolver,
  completedCoursesResolver,
} from "./resolvers";
import { nukeAccount } from "./util/nukeAccount";
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

const loginHandler = (parsedToken, googleId, done) => {
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
        .raw(`${initLessons} ON CONFLICT (user_id, set_lesson_id) DO NOTHING`)
        .transacting(trx);
    });

    return done(null, {
      email: parsedToken.payload.email,
      name: parsedToken.payload.name,
      picture: parsedToken.payload.picture,
      google_id: parsedToken.payload.googleId,
    });
  }
  return done(null, false);
};

passport.use(
  "ios",
  new GoogleTokenStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID_IOS,
    },
    loginHandler
  )
);

passport.use(
  "android",
  new GoogleTokenStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID_WEB,
    },
    loginHandler
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
    completedCourses: completedCoursesResolver(pg),
    nextUnlockCourses: nextUnlockCoursesResolver(pg),
    course: userCourseResolver(pg),
  },
  Mutation: {
    addLessonResults: addLessonResultsResolver(pg),
    sendGender: sendGenderResolver(pg),
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => ({
    session: req.session,
  }),
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

app.use(express.json()); // for parsing application/json

app.post("/login", passport.authenticate(["ios", "android"]), (req, res) => {
  res.json(req.user);
});

app.post("/logout", (req, res) => {
  req.logout();
  res.json({ success: true });
});

app.post("/nuke_account", (req, res) => {
  if (req.session.passport.user == null) {
    res.json({ success: false });
    return;
  }
  // If the logged in user is the same as the user that is being deleted, AND the
  // special confirmation string is correct (no accidental postman requests permanently
  // deleting accounts) then we nuke the account and all it stands for.
  // The confirmation string isn't a secret, it's just there to make it difficult to
  // accidentally nuke an account.
  if (
    req.session.passport.user.email === req.body.email &&
    req.body.confirmation === "WHO's thhe MAn now dog?"
  ) {
    nukeAccount(req.body.email, pg);
    res.json({ success: true });
  } else {
    res.json({ success: false });
  }
});

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "/../src/static/index.html"));
});
app.get("/terms", (req, res) => {
  res.sendFile(path.join(__dirname, "/../src/static/terms.html"));
});
app.get("/privacy", (req, res) => {
  res.sendFile(path.join(__dirname, "/../src/static/privacy_policy.html"));
});
app.use(express.static("public"));

// I don't yet know what cors actually does. Probably shouldn't enable it until I do...
// const corsOptions = {
//   origin: ["https://www.issei.com.au"],
//   credentials: true,
// };

// app.use(cors(corsOptions));

// Disable cors here otherwise the options defined above will be overwritten
server.applyMiddleware({ app /* , cors: false */ });

app.listen({ port: 80 }, () =>
  console.log(
    `running apollo server at https://www.issei.com.au${server.graphqlPath}`
  )
);
