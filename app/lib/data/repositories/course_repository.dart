// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:app/data/models/course.dart';
import 'package:app/domain/repositories/i_course_repository.dart';
import 'package:app/domain/service/i_http_client.dart';

class CourseRepository implements ICourseRepository {
  final IHttpClient client;
  CourseRepository({
    required this.client,
  });

  final _baseUrl = 'http://localhost:8080/courses';

  @override
  Future<ApiResponse<List<Course>?>> getAll() async {
    final url = '$_baseUrl/get_all';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);

        final List<Course> courses = body
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList();

        return (data: courses, error: Empty());
      } else {
        return (data: null, error: Failure(message: 'Failed to fetch courses'));
      }
    } catch (error, stacktrace) {
      log('error: $error\nstacktrace: $stacktrace');
      return (data: null, error: Failure(message: 'An error occurred'));
    }
  }

  @override
  Future<ApiResponse<String?>> save({
    required String description,
    required String courseSyllabus,
  }) async {
    final body = {
      "descricao": description,
      "ementa": courseSyllabus,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    final url = '$_baseUrl/save';
    try {
      final response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return (data: 'Curso criado com sucesso.', error: Empty());
      } else {
        return (data: null, error: Failure(message: 'Erro ao criar o curso.'));
      }
    } catch (e) {
      return (
        data: null,
        error: Failure(message: 'Erro ao tentar se conectar com o servidor.')
      );
    }
  }

  @override
  Future<ApiResponse<String?>> delete(int id) async {
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
          error:
              Failure(message: 'Erro desconhecido ao tentar excluir o curso.')
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
  Future<ApiResponse<String?>> update({
    required int id,
    required String description,
    required String courseSyllabus,
  }) async {
    final url = '$_baseUrl/update_by_id?id=$id';

    final body = {
      "descricao": description,
      "ementa": courseSyllabus,
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
          error: Failure(message: 'Erro desconhecido ao tentar vincular aluno.')
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
