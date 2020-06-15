Dev FAQ

- `[GraphQL error]: Message: Cannot read property 'user' of undefined, Location: [object Object], Path: user`
  - The current express session has no passport value, which is `undefined`. Thus, it has no user.
    Most likely caused by the cookie header not being forwarded by CloudFront, or no cookie header
    being sent by the app at all.
