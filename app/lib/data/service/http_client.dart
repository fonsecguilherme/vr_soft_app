import 'package:http/http.dart' as http;

import '../../domain/service/i_http_client.dart';

class HttpClient implements IHttpClient {
  final http.Client client;

  const HttpClient(this.client);

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (e) {
      throw Exception('An error happened: $e');
    }
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: headers,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (e) {
      throw Exception('An error happened: $e');
    }
  }

  @override
  Future<HttpResponse> delete(String url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      final response = await client.delete(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (e) {
      throw Exception('An error happened: $e');
    }
  }

  @override
  Future<HttpResponse> put(String url,
      {Map<String, String>? headers, Object? body})async {
    try {
      final response = await client.put(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return HttpResponse(
        body: response.body,
        statusCode: response.statusCode,
      );
    } catch (e) {
      throw Exception('An error happened: $e');
    }
  }
}
