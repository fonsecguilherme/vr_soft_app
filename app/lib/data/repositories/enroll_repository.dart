import 'package:app/domain/repositories/i_enroll_repository.dart';

import '../../domain/repositories/i_course_repository.dart';
import '../../domain/service/i_http_client.dart';

class EnrollRepository implements IEnrollRepository {
  final IHttpClient client;
  EnrollRepository({
    required this.client,
  });

  final _baseUrl = 'http://localhost:8080/enroll';

  @override
  Future<ApiResponse<String?>> delete({
    required int courseId,
    required int studentId,
  }) async {
    final url =
        '$_baseUrl/remove_student?courseId=$courseId&studentId=$studentId';

    try {
      final response = await client.delete(url);

      if (response.statusCode == 200) {
        return (data: 'Aluno excluído do curso com sucesso!', error: Empty());
      } else if (response.statusCode == 404) {
        return (data: null, error: Failure(message: response.body));
      } else {
        return (
          data: null,
          error: Failure(message: 'Erro desconhecido ao tentar editar o curso.')
        );
      }
    } catch (e) {
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }

  @override
  Future<ApiResponse<String?>> save({
    required int courseId,
    required int studentId,
  }) async {
    final url =
        '$_baseUrl/assign_student?courseId=$courseId&studentId=$studentId';

    try {
      final response = await client.post(url);

      if (response.statusCode == 200) {
        return (data: 'Aluno matriculado', error: Empty());
      } else if (response.statusCode == 404) {
        return (data: null, error: Failure(message: response.body));
      } else {
        return (
          data: null,
          error:
              Failure(message: 'Erro desconhecido ao tentar matricular aluno')
        );
      }
    } catch (e) {
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }
}
