abstract class IEnrollRepository {
  Future<String> save({
    required int courseId,
    required int studentId,
  });
  Future<String> delete({
    required int courseId,
    required int studentId,
  });
}
