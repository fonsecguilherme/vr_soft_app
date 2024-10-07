abstract class IStudentRepository {
  Future<void> getAll();
  Future<void> save(String name);
  Future<void> update(int id, String name);
  Future<void> delete(int id);
}
