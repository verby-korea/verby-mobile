import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  test(
    'ApiClient Unit Test',
    () {
      final ApiClient apiClient = ApiClient();

      expect(
        apiClient.headers[HttpHeaders.contentTypeHeader],
        'application/json;charset=UTF-8',
      );

      expect(apiClient.baseUrl, 'https://api.verby.co.kr');

      expect(apiClient.sessionKey, null);

      apiClient.setSession(sessionKey: 'SESSION-KEY');

      expect(apiClient.sessionKey, 'SESSION-KEY');

      expect(apiClient.headers[HttpHeaders.authorizationHeader], 'SESSION-KEY');

      apiClient.removeSession();

      expect(apiClient.sessionKey, null);

      expect(apiClient.headers[HttpHeaders.authorizationHeader], null);

      apiClient.setHeader(key: 'test-key', value: 'TEST-VALUE');

      expect(apiClient.headers['test-key'], 'TEST-VALUE');
    },
  );
}
