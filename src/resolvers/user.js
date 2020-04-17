// @flow

export const userResolver = (pg) => {
  return async (obj, args, context, info) =>
    await pg("accounts")
      .where("id", args.id)
      .then((users) => users[0]);
};
