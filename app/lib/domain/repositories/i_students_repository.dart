import 'package:app/data/models/student.dart';
import 'package:app/domain/repositories/i_course_repository.dart';

abstract class IStudentRepository {
  Future<ApiResponse<List<Student>?>> getAll();
  Future<ApiResponse<String?>> save({
    required String name,
  });
  Future<ApiResponse<String?>> delete({
    required int id,
  });
  Future<ApiResponse<String?>> update({
    required int id,
    required String name,
  });
}
