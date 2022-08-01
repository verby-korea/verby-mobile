import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:verby_mobile/services/services.dart';

abstract class RouteData extends Equatable {
  const RouteData();
}

class RouteArguments<T extends RouteData> extends Equatable {
  // https://api.flutter.dev/flutter/widgets/PageRoute/fullscreenDialog.html
  final bool fullscreenDialog;
  final RouteTransitions trasition;
  final T? data;

  const RouteArguments({
    this.fullscreenDialog = false,
    this.trasition = RouteTransitions.slideLeft,
    this.data,
  });

  @override
  String toString() => '''
RouteArguments(
  fullscreenDialog: $fullscreenDialog,
  transition: $trasition,
  data: $data,
);
''';

  @override
  List<Object?> get props => [
        fullscreenDialog,
        trasition,
        data,
      ];
}

typedef NestedRouteBuilder = Widget? Function({
  required Widget child,
  required RouteData? data,
});

class NestedRouteException implements Exception {
  final String message;

  const NestedRouteException({
    required this.message,
  });

  @override
  String toString() => '[NestedRouteException] $message';
}

@immutable
class NestedRoute {
  final NestedRouteBuilder builder;
  final String name;
  final List<NestedRoute>? subRoutes;

  const NestedRoute({
    required this.builder,
    required this.name,
    this.subRoutes,
  });

  Route buildRoute({
    required List<String> paths,
    required int index,
    required RouteSettings settings,
  }) {
    var arguments = settings.arguments;
    if (arguments is! RouteArguments?) {
      throw const NestedRouteException(message: '`settings.arguments` must be `RouteArguments?`.');
    }

    arguments = arguments ?? const RouteArguments();

    final data = arguments.data;

    return arguments.trasition.getRoute(
      builder: (_) => build(paths: paths, index: index, data: data),
      fullscreenDialog: arguments.fullscreenDialog,
      settings: settings,
    );
  }
}

extension on NestedRoute {
  Widget build({
    required List<String> paths,
    required int index,
    required RouteData? data,
  }) {
    if (index >= paths.length) return buildDefaultWidget(paths: paths, data: data);

    final unsupportedException = NestedRouteException(
      message: '[NestedRouteException] unsupported route - ${paths.join('/')}',
    );

    final subRoute = subRoutes?.firstWhere(
      (route) => route.name == paths[index],
      orElse: () => throw unsupportedException,
    );
    if (subRoute == null) throw unsupportedException;

    final subRouteBuilder = builder(
      child: subRoute.build(
        paths: paths,
        index: index + 1,
        data: data,
      ),
      data: data,
    );

    return subRouteBuilder ?? buildDefaultWidget(paths: paths, data: data);
  }

  Widget buildDefaultWidget({
    required List<String> paths,
    required RouteData? data,
  }) {
    assert(
      false,
      '''
[NestedRoute] on `buildDefaultWidget` method
- RouteData($data) is not handled!
- RouteData($data) is not valid type of route - ${paths.join('/')}.
''',
    );

    // TODO: implements 404 Screens
    return const SizedBox();
  }
}
