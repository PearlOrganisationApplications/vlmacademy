import '../models/course_model.dart';

abstract class LearningRepository {
  Future<List<CourseModel>> getCourses({String? subject, String? classLevel});
  Future<CourseModel?> getCourseById(String id);
  Future<List<CourseModel>> getLiveClasses();
  Future<bool> markVideoAsCompleted(String courseId, String userId);
  Future<List<CourseModel>> getRecommendedCourses(String userId);
}
