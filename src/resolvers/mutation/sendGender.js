/* @flow */
import { userMarshaller } from "../query/user";

export const sendGenderResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (
    _: mixed,
    { userEmail, gender }: { userEmail: string, gender: string }
  ) => {
    return userMarshaller(
      await pg("accounts").where({ email: userEmail }).update({ gender }, "*")
    );
  };
};
