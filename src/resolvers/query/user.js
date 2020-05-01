// @flow

export const userResolver = (pg) => {
  return async (obj, args, context, info) =>
    console.log("context in userResolver", context) ||
    (await pg("accounts")
      .where("email", args.email)
      .then((users) => users[0]));
};
