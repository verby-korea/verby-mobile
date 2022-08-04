import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

import 'navigator_test_observer.dart';

void main() {
  NavigationService.init(
    nestedRoutes: [
      NestedRoute(
        builder: (child, _) => child,
        name: 'mock',
        subRoutes: [
          NestedRoute(
            builder: (_, __) => Builder(
              builder: (context) {
                final navigator = Navigator.of(context);

                return Scaffold(
                  body: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => navigator.pushNamed('/mock/test-1'),
                        child: const Text('Navigate To Test1'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => navigator.pushNamed('/mock/test-2'),
                        child: const Text('Navigate To Test2'),
                      ),
                    ],
                  ),
                );
              },
            ),
            name: 'home',
          ),
          NestedRoute(
            builder: (_, __) => const SizedBox(),
            name: 'test-1',
          ),
          NestedRoute(
            builder: (_, __) => null,
            name: 'test-2',
          ),
        ],
      ),
    ],
  );

  group(
    'Test `NavigationService` Unit Test',
    () {
      testThrowUnsupportedError();

      testThrowNestedRouteException();

      testBuildUnsupportedRouteWidget();

      testNavigationSucceed();
    },
  );
}

void testThrowUnsupportedError() {
  group(
    'Test throw UnsupportedError on `buildRouteFactoryByNestedRoutes` method',
    () {
      final RouteFactory routeFactory = NavigationService.instance.routes;

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
            routeFactory(const RouteSettings(name: 'mock/test-1'));
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
            routeFactory(const RouteSettings(name: '/mock/test-1'));
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

void testThrowNestedRouteException() {
  group(
    'Test throw NestedRouteException on `buildRoute` in `buildRouteFactoryByNestedRoute`',
    () {
      test(
        'Test throw NestedRouteException when `settings.arguments is! RouteArguments?`',
        () {
          final RouteFactory routeFactory = NavigationService.instance.routes;

          try {
            routeFactory(
              const RouteSettings(
                name: '/mock/test-1',
                arguments: 'Wrogn Arguments Type',
              ),
            );
          } catch (error) {
            expect(error.runtimeType, NestedRouteException);

            error as NestedRouteException;

            expect(error.message, '`settings.arguments` must be `RouteArguments?`.');
          }
        },
      );

      test(
        'Test throw NestedRouteException when can\'t find subRoute',
        () {
          final RouteFactory routeFactory = NavigationService.instance.routes;

          try {
            routeFactory(
              const RouteSettings(
                name: '/mock/test',
                arguments: RouteArguments(),
              ),
            );
          } catch (error) {
            expect(error.runtimeType, NestedRouteException);

            error as NestedRouteException;

            expect(error.message, '[NestedRouteException] unsupported route - /mock/test');
          }
        },
      );
    },
  );
}

void testBuildUnsupportedRouteWidget() {
  testWidgets(
    'Test Build UnsupportedRouteWidget when NestedRouteException',
    (WidgetTester widgetTester) async {
      WidgetBuilder? builder;

      final NavigatorTestObserver navigatorTestObserver = NavigatorTestObserver()
        ..onPushed = (Route<dynamic>? route, Route<dynamic>? previousRoute) {
          expect(route.runtimeType, SlideLeftMaterialPageRoute);

          route = route as SlideLeftMaterialPageRoute;

          builder = route.builder;
        };

      final widget = MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        initialRoute: '/mock/home',
        onGenerateRoute: NavigationService.instance.routes,
        navigatorObservers: [navigatorTestObserver],
      );

      await widgetTester.pumpWidget(widget);

      final navigateToTest2ScreenButton = find.widgetWithText(ElevatedButton, 'Navigate To Test2');
      await widgetTester.tap(navigateToTest2ScreenButton);

      expect(builder != null, true);

      final context = NavigationService.instance.navigatorKey.currentContext;
      expect(context != null, true);

      expect(
        () => builder!(context!), // use `!` operator
        throwsAssertionError,
      );
    },
  );
}

void testNavigationSucceed() {
  testWidgets(
    'Test Navigation Succeed using by NavigationService',
    (WidgetTester widgetTester) async {
      final List<NavigatorObservation> navigatorObservations = [];

      final NavigatorTestObserver navigatorTestObserver = NavigatorTestObserver()
        ..onPushed = (Route<dynamic>? route, Route<dynamic>? previousRoute) {
          navigatorObservations.add(
            NavigatorObservation(
              type: ObservationType.push,
              current: route?.settings.name,
              previous: previousRoute?.settings.name,
            ),
          );
        };

      final widget = MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        initialRoute: '/mock/home',
        onGenerateRoute: NavigationService.instance.routes,
        navigatorObservers: [navigatorTestObserver],
      );

      await widgetTester.pumpWidget(widget);

      navigatorObservations.clear();

      final navigateToTest1ScreenButton = find.widgetWithText(ElevatedButton, 'Navigate To Test1');

      await widgetTester.tap(navigateToTest1ScreenButton);

      expect(navigatorObservations.length, 1);
      expect(
        navigatorObservations[0],
        const NavigatorObservation(
          type: ObservationType.push,
          current: '/mock/test-1',
          previous: '/mock/home',
        ),
      );
    },
  );
}
