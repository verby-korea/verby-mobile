import 'package:flutter/material.dart';
import 'package:verby_mobile/services/services.dart';

class NavigationService {
  late final GlobalKey<NavigatorState> navigatorKey;
  late final List<NestedRoute> nestedRoutes;
  late final RouteFactory routes;

  static final NavigationService _instance = NavigationService._internal();

  NavigationService._internal();

  static NavigationService get instance => _instance;

  factory NavigationService() => _instance;

  static void init({required List<NestedRoute> nestedRoutes}) {
    nestedRoutes = [
      // MaterialApp's initialRoute
      // Even if the route was just /a, the app would start with / and /a loaded
      NestedRoute(
        builder: (_, __) => const SizedBox(),
        name: '',
      ),
      ...nestedRoutes,
    ];

    instance.navigatorKey = GlobalKey<NavigatorState>();
    instance.nestedRoutes = nestedRoutes;
    instance.routes = buildRouteFactoryByNestedRoutes(nestedRoutes: nestedRoutes);
  }

  static RouteFactory buildRouteFactoryByNestedRoutes({required List<NestedRoute> nestedRoutes}) {
    return (settings) {
      const String unsupportedErrorType = '[buildRouteFactoryByNestedRoutes]';

      final name = settings.name;
      if (name == null) {
        throw UnsupportedError('$unsupportedErrorType: name must be not null');
      }

      if (!name.startsWith('/')) {
        throw UnsupportedError('$unsupportedErrorType: route must start with slash - $name');
      }

      final paths = name.split('/').sublist(1);
      final rootRoute = nestedRoutes.firstWhere(
        (route) => route.name == paths[0],
        orElse: () => throw UnsupportedError('$unsupportedErrorType: unsupported route - $name'),
      );

      return rootRoute.buildRoute(
        paths: paths,
        index: 1,
        settings: settings,
      );
    };
  }
}
