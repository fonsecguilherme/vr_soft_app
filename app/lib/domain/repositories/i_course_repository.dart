import 'package:app/data/models/course.dart';

typedef ApiResponse<T> = ({T? data, Error error});

abstract class ICourseRepository {
  Future<ApiResponse<List<Course>?>> getAll();
  Future<void> save({
    required String description,
    required String courseSyllabus,
  });
  Future<void> update({
    required int id,
    required String description,
    required String courseSyllabus,
  });
  Future<void> delete(int id);
}

abstract interface class Error {}

final class Failure implements Error {
  final String message;

  Failure({required this.message});
}

final class Empty implements Error {}
