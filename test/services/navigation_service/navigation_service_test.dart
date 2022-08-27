import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

import 'navigator_test_observer.dart';

class _MockRoutes {
  _MockRoutes._();

  static const String _rootRouteName = 'mock';

  static final NestedRoute route = NestedRoute(
    name: _rootRouteName,
    builder: (child, _) => child,
    subRoutes: [
      _home,
      _test1,
      _test2,
    ],
  );

  static final NestedRoute _home = NestedRoute(
    name: 'home',
    builder: (_, __) => const _MockHomeScreen(),
  );
  static String get homeRouteName => '/$_rootRouteName/${_home.name}';

  static final NestedRoute _test1 = NestedRoute(
    name: 'test-1',
    builder: (_, __) => const SizedBox(),
  );
  static String get test1RouteName => '/$_rootRouteName/${_test1.name}';

  static final NestedRoute _test2 = NestedRoute(
    name: 'test-2',
    builder: (_, __) => null,
  );
  static String get test2RouteName => '/$_rootRouteName/${_test2.name}';
}

void main() {
  final navigationService = NavigationService(
    nestedRoutes: [_MockRoutes.route],
  );

  group(
    'Test `NavigationService` Unit Test',
    () {
      testThrowUnsupportedError(navigationService: navigationService);

      testThrowNestedRouteException(navigationService: navigationService);

      testBuildUnsupportedRouteWidget(navigationService: navigationService);

      testNavigationSucceed(navigationService: navigationService);
    },
  );
}

void testThrowUnsupportedError({required NavigationService navigationService}) {
  group(
    'Test throw UnsupportedError on `buildRouteFactoryByNestedRoutes` method',
    () {
      final RouteFactory onGenerateRoute = navigationService.onGenerateRoute;

      test(
        'Test throw UnsupportedError when RouteSettings.name == null',
        () {
          try {
            onGenerateRoute(const RouteSettings());
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
          final targetRouteName = _MockRoutes.test1RouteName;

          try {
            onGenerateRoute(RouteSettings(name: targetRouteName));
          } catch (error) {
            expect(error.runtimeType, UnsupportedError);

            error as UnsupportedError;

            expect(error.message, '[buildRouteFactoryByNestedRoutes]: route must start with slash - $targetRouteName');
          }
        },
      );

      test(
        'Test throw UnsupportedError when can\'t find rootRoute',
        () {
          final targetRouteName = _MockRoutes.test1RouteName;

          try {
            onGenerateRoute(RouteSettings(name: targetRouteName));
          } catch (error) {
            expect(error.runtimeType, UnsupportedError);

            error as UnsupportedError;

            expect(error.message, '[buildRouteFactoryByNestedRoutes]: unsupported route - $targetRouteName');
          }
        },
      );
    },
  );
}

void testThrowNestedRouteException({required NavigationService navigationService}) {
  group(
    'Test throw NestedRouteException on `buildRoute` in `buildRouteFactoryByNestedRoute`',
    () {
      test(
        'Test throw NestedRouteException when `settings.arguments is! RouteArguments?`',
        () {
          final RouteFactory onGenerateRoute = navigationService.onGenerateRoute;

          try {
            onGenerateRoute(
              RouteSettings(
                name: _MockRoutes.test1RouteName,
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
          final RouteFactory onGenerateRoute = navigationService.onGenerateRoute;

          try {
            onGenerateRoute(
              const RouteSettings(
                name: '/mock/test',
                arguments: RouteArguments(),
              ),
            );
          } catch (error) {
            expect(error.runtimeType, NestedRouteException);

            error as NestedRouteException;

            expect(error.message, 'unsupported route - /mock/test');
          }
        },
      );
    },
  );
}

void testBuildUnsupportedRouteWidget({required NavigationService navigationService}) {
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
        navigatorKey: navigationService.navigatorKey,
        initialRoute: _MockRoutes.homeRouteName,
        onGenerateRoute: navigationService.onGenerateRoute,
        navigatorObservers: [navigatorTestObserver],
      );

      await widgetTester.pumpWidget(widget);

      final navigateToTest2ScreenButton = find.widgetWithText(ElevatedButton, 'Navigate To Test2');
      await widgetTester.tap(navigateToTest2ScreenButton);

      expect(builder != null, true);

      final context = navigationService.navigatorKey.currentContext;
      expect(context != null, true);

      expect(
        () => builder!(context!), // use `!` operator
        throwsAssertionError,
      );
    },
  );
}

void testNavigationSucceed({required NavigationService navigationService}) {
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
        navigatorKey: navigationService.navigatorKey,
        initialRoute: _MockRoutes.homeRouteName,
        onGenerateRoute: navigationService.onGenerateRoute,
        navigatorObservers: [navigatorTestObserver],
      );

      await widgetTester.pumpWidget(widget);

      navigatorObservations.clear();

      final navigateToTest1ScreenButton = find.widgetWithText(ElevatedButton, 'Navigate To Test1');

      await widgetTester.tap(navigateToTest1ScreenButton);

      expect(navigatorObservations.length, 1);
      expect(
        navigatorObservations[0],
        NavigatorObservation(
          type: ObservationType.push,
          current: _MockRoutes.test1RouteName,
          previous: _MockRoutes.homeRouteName,
        ),
      );
    },
  );
}

class _MockHomeScreen extends StatelessWidget {
  const _MockHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => navigator.pushNamed(_MockRoutes.test1RouteName),
            child: const Text('Navigate To Test1'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => navigator.pushNamed(_MockRoutes.test2RouteName),
            child: const Text('Navigate To Test2'),
          ),
        ],
      ),
    );
  }
}
