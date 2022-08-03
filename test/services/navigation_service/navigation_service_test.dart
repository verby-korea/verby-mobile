import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  group(
    'Test `NavigationService` Unit Test',
    () {
      testThrowUnsupportedError();
    },
  );
}

void testThrowUnsupportedError() {
  group(
    'Test throw UnsupportedError on `buildRouteFactoryByNestedRoutes` method',
    () {
      final RouteFactory routeFactory = NavigationService.buildRouteFactoryByNestedRoutes(nestedRoutes: []);

      test(
        'Test throw UnsupportedError when RouteSettings.name == null',
        () {
          try {
            routeFactory(const RouteSettings());
          } catch (error) {
            expect(error.runtimeType, UnsupportedError);

            error as UnsupportedError;

            expect(error.message, '[buildRouteFactoryByNestedRoutes]: name must be not null');
          }
        },
      );

      test(
        'Test throw UnsupportedError when !RouteSettings.name.startsWith(\'/\');',
        () {
          try {
            routeFactory(
              const RouteSettings(name: 'mock/test-1'),
            );
          } catch (error) {
            expect(error.runtimeType, UnsupportedError);

            error as UnsupportedError;

            expect(error.message, '[buildRouteFactoryByNestedRoutes]: route must start with slash - mock/test-1');
          }
        },
      );

      test(
        'Test throw UnsupportedError when can\'t find rootRoute',
        () {
          try {
            routeFactory(
              const RouteSettings(name: '/mock/test-1'),
            );
          } catch (error) {
            expect(error.runtimeType, UnsupportedError);

            error as UnsupportedError;

            expect(error.message, '[buildRouteFactoryByNestedRoutes]: unsupported route - /mock/test-1');
          }
        },
      );
    },
  );
}
