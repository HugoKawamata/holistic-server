/* @flow */
import type { UserCourseJoinCourseDB } from "../../types/db";
import type { UserGQL } from "../../types/gql";
import {
  availableLessonsResolver,
  completedLessonsResolver,
  lessonsResolver,
  nextUnlockLessonsResolver,
} from "./lesson";

const marshalUserCourse = (dbCourse, userId, pg) => {
  return {
    id: dbCourse.course_id,
    title: dbCourse.title,
    availableLessons: availableLessonsResolver(dbCourse, userId, pg),
    nextUnlockLessons: nextUnlockLessonsResolver(dbCourse, userId, pg),
    completedLessons: completedLessonsResolver(dbCourse, userId, pg),
    lessons: lessonsResolver(dbCourse, pg),
  };
};

const marshalCourse = (dbCourse, pg) => {
  return {
    id: dbCourse.id,
    title: dbCourse.title,
    lessons: lessonsResolver(dbCourse, pg),
  };
};

export const completedCoursesResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (user: UserGQL) => {
    const courses = await pg("user_courses")
      .where({
        user_id: user.id,
        status: "COMPLETED",
      })
      .join("courses", "courses.id", "=", "user_courses.course_id");

    return courses.map((course) => marshalUserCourse(course, user.id, pg));
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

    return courses.map((course) => marshalUserCourse(course, user.id, pg));
  };
};

export const nextUnlockCoursesResolver = (
  pg: any // eslint-disable-line flowtype/no-weak-types
) => {
  return async (user: UserGQL) => {
    const availableCourses = await pg("user_courses")
      .where({
        user_id: user.id,
        status: "AVAILABLE",
      })
      .join("courses", "courses.id", "=", "user_courses.course_id");

    const nextUnlockCourseIds = availableCourses.reduce(
      (acc, course) =>
        typeof course.unlocks_ids === "string"
          ? acc.concat(course.unlocks_ids.split(","))
          : acc,
      []
    );

    const courses = await pg("courses").whereIn("id", nextUnlockCourseIds);

    return courses.map((course) => marshalCourse(course, pg));
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

    return marshalUserCourse(course, user.id, pg);
  };
};
