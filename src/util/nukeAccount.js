/* @flow */

export function nukeAccount(
  email: string,
  pg: any // eslint-disable-line flowtype/no-weak-types
) {
  pg.transaction((trx) => {
    // All child records should cascade on delete
    pg("accounts")
      .where("email", email)
      .del()
      .transacting(trx)
      .then(trx.commit)
      .catch(trx.rollback);
  });
}
