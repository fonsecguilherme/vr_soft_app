import 'package:app/domain/repositories/i_enroll_repository.dart';

import '../../domain/service/i_http_client.dart';

class EnrollRepository implements IEnrollRepository {
  final IHttpClient client;
  EnrollRepository({
    required this.client,
  });

  final _baseUrl = 'http://localhost:8080/enroll';

  @override
  Future<String> delete({
    required int courseId,
    required int studentId,
  }) async {
    final url =
        '$_baseUrl/remove_student?courseId=$courseId&studentId=$studentId';

    try {
      final response = await client.delete(url);

      if (response.statusCode == 200) {
        return 'Aluno excluído do curso com sucesso!';
      } else if (response.statusCode == 404) {
        return response.body;
      } else {
        return 'Erro desconhecido ao tentar editar o curso.';
      }
    } catch (e) {
      return 'Erro ao tentar se conectar com o servidor.';
    }
  }

  @override
  Future<String> save({
    required int courseId,
    required int studentId,
  }) async {
    final url =
        '$_baseUrl/assign_student?courseId=$courseId&studentId=$studentId';

    try {
      final response = await client.post(url);

      if (response.statusCode == 200) {
        return 'Aluno matriculado';
      } else if (response.statusCode == 404) {
        return response.body;
      } else {
        return 'Erro desconhecido ao tentar matricular aluno';
      }
    } catch (e) {
      return 'Erro ao tentar se conectar com o servidor.';
    }
  }
}
