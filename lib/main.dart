import 'package:flutter/material.dart';
import 'package:verby_mobile/app.dart';
import 'package:verby_mobile/routes.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  Routes.setRoutes();

  ApiService.init();

  runApp(const App());
}
