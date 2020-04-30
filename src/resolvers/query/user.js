// @flow

export const userResolver = (pg) => {
  return async (obj, args, context, info) =>
    await pg("accounts")
      .where("email", args.email)
      .then((users) => users[0]);
};
