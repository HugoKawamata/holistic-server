/* @flow */
export const meResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (
    obj: mixed,
    args: mixed,
    context: {
      session: {
        passport: {
          user: {
            email: string,
          },
        },
      },
    }
  ) => {
    if (context.session.passport.user == null) {
      // No user logged in, so do not get any data
      return null;
    }

    return pg("accounts")
      .where("email", context.session.passport.user.email)
      .then((users) => ({
        ...users[0],
        kanaLevel: users[0].kana_level,
      }));
  };
};

export const userResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (
    obj: mixed,
    args: { email: string },
    context: {
      session: {
        passport: {
          user: {
            email: string,
          },
        },
      },
    }
  ) => {
    if (
      context.session.passport.user == null ||
      context.session.passport.user.email !== args.email
    ) {
      // Only let authenticated user retrieve their own data
      return null;
    }

    return pg("accounts")
      .where("email", args.email)
      .then((users) => ({
        ...users[0],
        kanaLevel: users[0].kana_level,
      }));
  };
};
