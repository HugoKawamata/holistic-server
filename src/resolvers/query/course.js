import { availableLessonsResolver, completedLessonsResolver } from "./lesson";

export const availableCoursesResolver = (pg) => {
  return async (user, args) => {
    const courses = await pg("user_courses")
      .where({
        user_id: user.id,
        status: "AVAILABLE",
      })
      .join("courses", "courses.id", "=", "user_courses.course_id");

    return courses.map((course) => marshalUserCourse(course, pg));
  };
};

export const userCourseResolver = (pg) => {
  return async (user, args) => {
    const course = await pg("user_courses")
      .where({
        user_id: user.id,
        course_id: args.id,
      })
      .join("courses", "courses.id", "=", "user_courses.course_id")
      .then((course) => course[0]);

    return marshalUserCourse(course, pg);
  };
};

const marshalUserCourse = (dbCourse, pg) => {
  return {
    id: dbCourse.course_id,
    title: dbCourse.title,
    availableLessons: availableLessonsResolver(dbCourse, pg),
    completedLessons: completedLessonsResolver(dbCourse, pg),
  };
};
