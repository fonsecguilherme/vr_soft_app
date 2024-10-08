// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:app/domain/repositories/i_students_repository.dart';
import 'package:app/domain/service/i_http_client.dart';

import '../../domain/repositories/i_course_repository.dart';
import '../models/student.dart';

class StudentsRepository implements IStudentRepository {
  StudentsRepository({
    required this.client,
  });

  final IHttpClient client;

  final _baseUrl = 'http://localhost:8080/students';

  @override
  Future<ApiResponse<List<Student>?>> getAll() async {
    final url = '$_baseUrl/get_all';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final List<Student> students = (body as List)
            .map((e) => Student.fromJson(e as Map<String, dynamic>))
            .toList();

        return (data: students, error: Empty());
      } else {
        return (
          data: null,
          error: Failure(message: 'Erro ao obter lista de alunos')
        );
      }
    } catch (error, stacktrace) {
      log('error: $error\nstacktrace: $stacktrace');
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }

  @override
  Future<ApiResponse<String?>> save({required String name}) async {
    final url = '$_baseUrl/save';

    final body = {
      "nome": name,
    };
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return (data: 'Aluno registrado com sucesso.', error: Empty());
      } else {
        return (
          data: null,
          error: Failure(message: 'Erro ao registrar de aluno')
        );
      }
    } catch (error, stacktrace) {
      log('error: $error\nstacktrace: $stacktrace');
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }

  @override
  Future<ApiResponse<String?>> delete({required int id}) async {
    final url = '$_baseUrl/delete_by_id?id=$id';

    try {
      final response = await client.delete(url);
      if (response.statusCode == 200) {
        return (data: response.body, error: Empty());
      } else if (response.statusCode == 404) {
        return (data: null, error: Failure(message: response.body));
      } else if (response.statusCode == 409) {
        return (data: null, error: Failure(message: response.body));
      } else {
        return (
          data: null,
          error: Failure(message: 'Erro desconhecido ao tentar excluir aluno.')
        );
      }
    } catch (error, stacktrace) {
      log('error: $error\nstacktrace: $stacktrace');
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }

  @override
  Future<ApiResponse<String?>> update({
    required int id,
    required String name,
  }) async {
    final url = '$_baseUrl/update_by_id?id=$id';

    final body = {
      "nome": name,
    };
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await client.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return (data: 'Editado com sucesso.', error: Empty());
      } else if (response.statusCode == 404) {
        return (data: null, error: Failure(message: response.body));
      } else {
        return (
          data: null,
          error:
              Failure(message: 'Erro desconhecido ao tentar atualizar aluno.')
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
