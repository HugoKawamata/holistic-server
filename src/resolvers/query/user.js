/* @flow */
import type { UserDB } from "../../types/db";

const getFname = (name: string) => {
  const splitName = name.split(" ");
  if (splitName.length > 0) {
    return splitName[0];
  }
  return name;
};

export const userMarshaller = (dbUser: UserDB) => {
  return {
    ...dbUser,
    createdAt: dbUser.created_at,
    splots: {
      me: dbUser.gender === "M" ? "僕" : "私",
      meFuri: dbUser.gender === "M" ? "ぼく" : "わたし",
      fname: getFname(dbUser.name),
    },
  };
};

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
      .then((users) => userMarshaller(users[0]));
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
      .then((users) => userMarshaller(users[0]));
  };
};
