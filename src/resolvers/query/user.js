export const meResolver = (pg) => {
  return async (obj, args, context, info) => {
    if (context.session.passport.user == null) {
      // No user logged in, so do not get any data
      return null;
    }

    return await pg("accounts")
      .where("email", context.session.passport.user.email)
      .then((users) => ({
        ...users[0],
        kanaLevel: users[0].kana_level,
      }));
  };
};

export const userResolver = (pg) => {
  return async (obj, args, context, info) => {
    console.log(context.session.passport.user);
    if (
      context.session.passport.user == null ||
      context.session.passport.user.email != args.email
    ) {
      // Only let authenticated user retrieve their own data
      return null;
    }

    return await pg("accounts")
      .where("email", args.email)
      .then((users) => ({
        ...users[0],
        kanaLevel: users[0].kana_level,
      }));
  };
};
