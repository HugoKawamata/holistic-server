// @flow

export const nextLessonResolver = (pg) => {
  return (user, args) => {
    // No args given, just generate the next lesson with the defaults
    if (args == null) {
      console.log("this is the user arg");
      console.log(user);
      return {
        contentType: "HIRAGANA_A",
        preface: [],
        testables: [],
      };
    }
  };
};
