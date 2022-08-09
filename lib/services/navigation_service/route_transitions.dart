import 'package:flutter/material.dart';

enum RouteTransitions {
  fade,
  none,
  slideTop,
  slideRight,
  slideLeft,
}

extension RouteBuildExtension on RouteTransitions {
  Route getRoute({
    required WidgetBuilder builder,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) {
    switch (this) {
      case RouteTransitions.fade:
        return FadeAnimationMaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );
      case RouteTransitions.none:
        return NoAnimationMaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );
      case RouteTransitions.slideTop:
        return SlideTopMaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );
      case RouteTransitions.slideRight:
        return SlideRightMaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );
      case RouteTransitions.slideLeft:
      default:
        return SlideLeftMaterialPageRoute(
          builder: builder,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );
    }
  }
}

class FadeAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  FadeAnimationMaterialPageRoute({
    required super.builder,
    super.fullscreenDialog = false,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.fullscreenDialog = false,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class SlideTopMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlideTopMaterialPageRoute({
    required super.builder,
    super.fullscreenDialog = false,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutQuad));

    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

class SlideRightMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlideRightMaterialPageRoute({
    required super.builder,
    super.fullscreenDialog = false,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(-1.0, 0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutQuad));

    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

class SlideLeftMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlideLeftMaterialPageRoute({
    required super.builder,
    super.fullscreenDialog = false,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOutQuad));

    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
