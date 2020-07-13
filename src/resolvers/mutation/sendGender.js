/* @flow */

export const sendGenderResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (
    _: mixed,
    { userEmail, gender }: { userEmail: string, gender: string }
  ) => {
    await pg("accounts").where({ email: userEmail }).update({ gender });
    return true;
  };
};
