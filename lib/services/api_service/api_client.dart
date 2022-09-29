import 'dart:io';

class ApiClient {
  final String baseUrl = 'https://api.verby.co.kr';

  String? _sessionKey;
  String? get sessionKey => _sessionKey;

  final Map<String, String> _headers = {};
  Map<String, String> get headers => _headers;

  ApiClient() {
    setHeader(
      key: HttpHeaders.contentTypeHeader,
      value: 'application/json;charset=UTF-8',
    );
  }

  void setSession({required String sessionKey}) {
    _sessionKey = sessionKey;

    setHeader(key: HttpHeaders.authorizationHeader, value: sessionKey);
  }

  void removeSession() {
    _sessionKey = null;

    _headers.remove(HttpHeaders.authorizationHeader);
  }

  void setHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
  }
}
