import { availableLessonsResolver } from "./lesson";

export const availableCoursesResolver = (pg) => {
  return async (user, args) => {
    const courses = await pg("user_courses").where({
      user_id: user.id,
      status: "AVAILABLE",
    });

    console.log("all courses got", courses);

    return courses.map(
      (course) =>
        console.log("got course: ", course) || {
          id: course.id,
          title: course.title,
          availableLessons: availableLessonsResolver(course, pg),
        }
    );
  };
};
