abstract class IHttpClient {
  Future<HttpResponse> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<HttpResponse> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
}

class HttpResponse {
  final String body;
  final int statusCode;

  const HttpResponse({
    required this.body,
    required this.statusCode,
  });
}