import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef OnObservation = void Function(Route<dynamic>? route, Route<dynamic>? previousRoute);

enum ObservationType {
  push,
  pop,
  remove,
  replace,
}

class NavigatorObservation extends Equatable {
  final ObservationType type;
  final String? current;
  final String? previous;

  const NavigatorObservation({
    required this.type,
    required this.current,
    required this.previous,
  });

  @override
  String toString() => '''
[ NavigatorObservation ]
- type: $type
- current: $current
- previous: $previous
''';

  @override
  List<Object?> get props => [
        type,
        current,
        previous,
      ];
}

// https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/observer_tester.dart
/// A trivial observer for testing the navigator.
class NavigatorTestObserver extends NavigatorObserver {
  OnObservation? onPushed;
  OnObservation? onPopped;
  OnObservation? onRemoved;
  OnObservation? onReplaced;
  OnObservation? onStartUserGesture;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPushed?.call(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPopped?.call(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onRemoved?.call(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? oldRoute, Route<dynamic>? newRoute}) {
    onReplaced?.call(newRoute, oldRoute);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onStartUserGesture?.call(route, previousRoute);
  }
}
