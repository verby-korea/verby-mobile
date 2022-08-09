import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

void main() {
  group(
    'RouteTransitions `RouteBuildExtension` Unit Test',
    () {
      testFadeRouteTransition();

      testNoneRouteTransition();

      testSlideTopRouteTransition();

      testSlideRightRouteTransition();

      testSlideLeftRouteTransition();
    },
  );
}

void testFadeRouteTransition() {
  testWidgets(
    'Test `RouteTransitions.fade` can generate `FadeAnimationMaterialPageRoute`',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Builder(
          builder: (context) {
            const fadeRouteTransition = RouteTransitions.fade;

            var route = fadeRouteTransition.getRoute(builder: (_) => const SizedBox());

            expect(route.runtimeType, FadeAnimationMaterialPageRoute);

            route = route as FadeAnimationMaterialPageRoute;

            final builder = route.builder(context);

            var transition = route.buildTransitions(
              context,
              kAlwaysDismissedAnimation,
              kAlwaysDismissedAnimation,
              builder,
            );

            expect(transition.runtimeType, FadeTransition);

            transition = transition as FadeTransition;

            expect(transition.opacity, kAlwaysDismissedAnimation);

            return const SizedBox();
          },
        ),
      );
    },
  );
}

void testNoneRouteTransition() {
  testWidgets(
    'Test `RouteTransitions.none` can generate `NoAnimationMaterialPageRoute`',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Builder(
          builder: (context) {
            const noneRouteTransition = RouteTransitions.none;

            var route = noneRouteTransition.getRoute(
              builder: (_) => const Text('NoneRouteTransition'),
            );

            expect(route.runtimeType, NoAnimationMaterialPageRoute);

            route = route as NoAnimationMaterialPageRoute;

            final builder = route.builder(context);

            var transition = route.buildTransitions(
              context,
              kAlwaysDismissedAnimation,
              kAlwaysDismissedAnimation,
              builder,
            );

            expect(transition.runtimeType, Text);

            transition = transition as Text;

            expect(transition.data, 'NoneRouteTransition');

            return const SizedBox();
          },
        ),
      );
    },
  );
}

void testSlideTopRouteTransition() {
  testWidgets(
    'Test `RouteTransitions.slideTop` can generate `SlideTopMaterialPageRoute`',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Builder(
          builder: (context) {
            const slideTopRouteTransition = RouteTransitions.slideTop;

            var route = slideTopRouteTransition.getRoute(builder: (_) => const SizedBox());

            expect(route.runtimeType, SlideTopMaterialPageRoute);

            route = route as SlideTopMaterialPageRoute;

            final builder = route.builder(context);

            var transition = route.buildTransitions(
              context,
              kAlwaysDismissedAnimation,
              kAlwaysDismissedAnimation,
              builder,
            );

            expect(transition.runtimeType, SlideTransition);

            transition = transition as SlideTransition;

            expect(transition.position.value, const Offset(0, 1));

            return const SizedBox();
          },
        ),
      );
    },
  );
}

void testSlideRightRouteTransition() {
  testWidgets(
    'Test `RouteTransitions.slideRight` can generate `SlideRightMaterialPageRoute`',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Builder(
          builder: (context) {
            const slideRightRouteTransition = RouteTransitions.slideRight;

            var route = slideRightRouteTransition.getRoute(builder: (_) => const SizedBox());

            expect(route.runtimeType, SlideRightMaterialPageRoute);

            route = route as SlideRightMaterialPageRoute;

            final builder = route.builder(context);

            var transition = route.buildTransitions(
              context,
              kAlwaysDismissedAnimation,
              kAlwaysDismissedAnimation,
              builder,
            );

            expect(transition.runtimeType, SlideTransition);

            transition = transition as SlideTransition;

            expect(transition.position.value, const Offset(-1.0, 0));

            return const SizedBox();
          },
        ),
      );
    },
  );
}

void testSlideLeftRouteTransition() {
  testWidgets(
    'Test `RouteTransitions.slideLeft` can generate `SlideLeftMaterialPageRoute`',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Builder(
          builder: (context) {
            const slideLeftRouteTransition = RouteTransitions.slideLeft;

            var route = slideLeftRouteTransition.getRoute(builder: (_) => const SizedBox());

            expect(route.runtimeType, SlideLeftMaterialPageRoute);

            route = route as SlideLeftMaterialPageRoute;

            final builder = route.builder(context);

            var transition = route.buildTransitions(
              context,
              kAlwaysDismissedAnimation,
              kAlwaysDismissedAnimation,
              builder,
            );

            expect(transition.runtimeType, SlideTransition);

            transition = transition as SlideTransition;

            expect(transition.position.value, const Offset(1.0, 0));

            return const SizedBox();
          },
        ),
      );
    },
  );
}
