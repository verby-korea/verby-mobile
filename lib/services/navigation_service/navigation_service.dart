import 'package:flutter/material.dart';
import 'package:verby_mobile/services/services.dart';

class NavigationService {
  late final GlobalKey<NavigatorState> navigatorState;
  late final List<NestedRoute> nestedRoutes;
  late final RouteFactory routes;

  static final NavigationService _instance = NavigationService._internal();

  NavigationService._internal();

  static NavigationService get instance => _instance;

  factory NavigationService() => _instance;

  static void init() {
    instance.navigatorState = GlobalKey<NavigatorState>();
  }
}
