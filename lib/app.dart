import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KO')],
      initialRoute: AccountRoutes.loginRouteName,
    );
  }
}
