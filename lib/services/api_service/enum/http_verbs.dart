import 'package:http/http.dart' as http;
import 'package:verby_mobile/services/services.dart';

enum HttpVerbs {
  post,
  get,
  put,
  patch,
  delete,
}

extension HttpVerbsExtension on HttpVerbs {
  Future<http.Response> call({
    required Uri uri,
    required Map<String, String> headers,
    String? body,
  }) async {
    switch (this) {
      case HttpVerbs.get:
        return http.get(
          uri,
          headers: headers,
        );
      case HttpVerbs.post:
        return http.post(
          uri,
          headers: headers,
          body: body,
        );
      case HttpVerbs.put:
        return http.put(
          uri,
          headers: headers,
          body: body,
        );
      case HttpVerbs.patch:
        return http.patch(
          uri,
          headers: headers,
          body: body,
        );
      case HttpVerbs.delete:
        return http.delete(
          uri,
          headers: headers,
          body: body,
        );
      default:
        throw const ApiHttpVerbsException();
    }
  }
}
