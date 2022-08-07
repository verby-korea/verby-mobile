import 'package:flutter/material.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();

    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: navigationService.routes,
      initialRoute: AccountRoutes.loginRouteName,
    );
  }
}
