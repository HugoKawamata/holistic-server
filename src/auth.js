// @flow
import passport from "passport";
import GoogleTokenStrategy from "passport-google-id-token";

require("dotenv").config();

passport.use(
  new GoogleTokenStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID_IOS,
    },
    function (parsedToken, googleId, done) {
      // Find or create user in db
      console.log("Passport used googlestrategy", parsedToken, googleId);
      return done(null, googleId);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((obj, done) => {
  done(null, obj);
});
