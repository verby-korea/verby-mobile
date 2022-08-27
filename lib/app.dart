import 'package:flutter/material.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = Routes.navigationService;

    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: navigationService.onGenerateRoute,
      initialRoute: AccountRoutes.loginRouteName,
    );
  }
}
