// @flow

export const userResolver = (pg) => {
  return async (obj, args, context, info) => {
    if (
      context.session.passport.user == null ||
      context.session.passport.email != args.email
    ) {
      // Only let authenticated user retrieve their own data
      return null;
    }

    return await pg("accounts")
      .where("email", args.email)
      .then((users) => users[0]);
  };
};
