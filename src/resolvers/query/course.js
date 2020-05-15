import { availableLessonsResolver } from "./lesson";

export const availableCourses = (pg) => {
  return async (user, args) => {
    const courses = await pg("user_courses").where({
      user_id: user.id,
      status: "AVAILABLE",
    });

    return courses.map((course) => ({
      id: course.id,
      title: course.title,
      availableLessons: availableLessonsResolver(course, pg),
    }));
  };
};
