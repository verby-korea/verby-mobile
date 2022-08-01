import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  group(
    'Test `NestedRoute` Unit Test',
    () {
      testWrongArgumentsOnRouteSettings();
    },
  );
}

void testWrongArgumentsOnRouteSettings() {
  test(
    'Test Use Wrong Arguments on RouteSettings',
    () {
      final NestedRoute nestedRoute = NestedRoute(
        builder: (_, __) => const SizedBox(),
        name: '',
      );

      try {
        const settings = RouteSettings(arguments: 'Wrong Arguments');

        nestedRoute.buildRoute(
          paths: [],
          index: 0,
          settings: settings,
        );
      } catch (e) {
        var exception = e;

        expect(exception.runtimeType, NestedRouteException);

        exception = exception as NestedRouteException;

        expect(exception.message, '`settings.arguments` must be `RouteArguments?`.');
      }
    },
  );
}
