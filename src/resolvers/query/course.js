/* @flow */
import type { UserCourseJoinCourseDB } from "../../types/db";
import type { UserGQL } from "../../types/gql";
import { availableLessonsResolver, completedLessonsResolver } from "./lesson";

const marshalUserCourse = (dbCourse, pg) => {
  return {
    id: dbCourse.course_id,
    title: dbCourse.title,
    availableLessons: availableLessonsResolver(dbCourse, pg),
    completedLessons: completedLessonsResolver(dbCourse, pg),
  };
};

export const availableCoursesResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (user: UserGQL) => {
    const courses = await pg("user_courses")
      .where({
        user_id: user.id,
        status: "AVAILABLE",
      })
      .join("courses", "courses.id", "=", "user_courses.course_id");

    return courses.map((course) => marshalUserCourse(course, pg));
  };
};

export const userCourseResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (user: UserGQL, args: { id: string }) => {
    const course = await pg("user_courses")
      .where({
        user_id: user.id,
        course_id: args.id,
      })
      .join("courses", "courses.id", "=", "user_courses.course_id")
      .then((c: UserCourseJoinCourseDB) => c[0]);

    return marshalUserCourse(course, pg);
  };
};
