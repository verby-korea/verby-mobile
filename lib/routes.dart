import 'package:verby_mobile/account/account.dart';

import 'services/services.dart';

class Routes {
  static final Routes _instance = Routes._internal();

  Routes._internal();

  factory Routes() => _instance;

  static late final NavigationService navigationService;

  static void setRoutes() {
    navigationService = NavigationService(
      nestedRoutes: [
        AccountRoutes.route,
      ],
    );
  }
}
