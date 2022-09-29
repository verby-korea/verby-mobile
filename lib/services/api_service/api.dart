import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:verby_mobile/services/services.dart';

class Api {
  final ApiClient apiClient;

  Api({required this.apiClient});
}

extension on Api {
  Future<Map<String, dynamic>?> invokeApi({
    required HttpVerbs verbs,
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    final Uri uri = Uri.parse(url);

    final Response response = await verbs.call(
      uri: uri,
      headers: headers ?? apiClient.headers,
      body: body,
    );

    final String? sessionKey = response.headers[HttpHeaders.setCookieHeader];
    if (sessionKey != null) apiClient.setSession(sessionKey: sessionKey);

    final int statusCode = response.statusCode;
    final String bodyStr = utf8.decode(response.bodyBytes);

    if (statusCode == HttpStatus.noContent && bodyStr == '') {
      return null;
    }

    final bool isSucceed = [
      HttpStatus.ok,
      HttpStatus.created,
    ].contains(statusCode);
    if (isSucceed) {
      final Map<String, dynamic> bodyJson = jsonDecode(bodyStr);

      return bodyJson;
    }

    throw ApiCallErrorException(
      statusCode: statusCode,
      body: jsonDecode(bodyStr),
    );
  }
}
