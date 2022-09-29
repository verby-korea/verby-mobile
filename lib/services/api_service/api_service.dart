import 'package:verby_mobile/services/services.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  ApiService._internal();

  static ApiService get instance => _instance;

  factory ApiService() => _instance;

  ApiClient? _apiClient;
  ApiClient get apiClient {
    final apiClient = _apiClient;
    if (apiClient == null) {
      throw const ApiServiceNotInitializedException(
        name: 'ApiService.instance.apiClient',
        method: 'ApiService.init()',
      );
    }

    return apiClient;
  }

  Api? _api;
  Api get api {
    final api = _api;
    if (api == null) {
      throw const ApiServiceNotInitializedException(
        name: 'ApiService.instance.api',
        method: 'ApiService.init()',
      );
    }

    return api;
  }

  static Future<void> init() async {
    instance._apiClient = ApiClient();

    instance._api = Api(apiClient: instance.apiClient);
  }
}
