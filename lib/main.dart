import 'package:flutter/material.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/app.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  NavigationService.init(
    nestedRoutes: [
      AccountRoutes.route,
    ],
  );

  runApp(const App());
}
