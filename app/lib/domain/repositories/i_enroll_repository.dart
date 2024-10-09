import 'i_course_repository.dart';

abstract class IEnrollRepository {
  Future<ApiResponse<String?>> save({
    required int courseId,
    required int studentId,
  });
  Future<ApiResponse<String?>> delete({
    required int courseId,
    required int studentId,
  });
}
