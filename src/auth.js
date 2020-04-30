// @flow
import passport from "passport";
import { Strategy as GoogleStrategy } from "passport-google-oauth20";

require("dotenv").config();

passport.use(
  new GoogleStrategy(
    {
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: "/return",
    },
    function (accessToken, refreshToken, profile, done) {
      // Find or create user in db
      console.log("Passport used googlestrategy", accessToken, profile);
      return done(null, profile);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
});
