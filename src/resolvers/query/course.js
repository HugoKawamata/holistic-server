import { availableLessonsResolver } from "./lesson";

export const availableCoursesResolver = (pg) => {
  return async (user, args) => {
    const courses = await pg("user_courses")
      .where({
        user_id: user.id,
        status: "AVAILABLE",
      })
      .join("courses", "courses.id", "=", "user_courses.course_id");

    return courses.map((course) => ({
      id: course.course_id,
      title: course.title,
      availableLessons: availableLessonsResolver(course, pg),
    }));
  };
};
