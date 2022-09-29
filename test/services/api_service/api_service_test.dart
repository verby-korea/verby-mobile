import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  test(
    'ApiService Unit Test',
    () async {
      final ApiService apiService = ApiService();

      try {
        apiService.apiClient;
      } catch (e) {
        var exception = e;

        expect(exception is ApiServiceNotInitializedException, true);

        exception = exception as ApiServiceNotInitializedException;

        expect(exception.name, 'ApiService.instance.apiClient');
        expect(exception.method, 'ApiService.init()');
        expect(
          exception.message,
          'ApiService.instance.apiClient is not initialized! Call `ApiService.init()` before use ApiService.instance.apiClient.',
        );
      }

      try {
        apiService.api;
      } catch (e) {
        var exception = e;

        expect(exception is ApiServiceNotInitializedException, true);

        exception = exception as ApiServiceNotInitializedException;

        expect(exception.name, 'ApiService.instance.api');
        expect(exception.method, 'ApiService.init()');
        expect(
          exception.message,
          'ApiService.instance.api is not initialized! Call `ApiService.init()` before use ApiService.instance.api.',
        );
      }

      await ApiService.init();

      expect(apiService.apiClient.runtimeType, ApiClient);

      expect(apiService.api.runtimeType, Api);
    },
  );
}
