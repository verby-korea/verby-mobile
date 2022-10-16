import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TimerWidgetController implements TickerProvider {
  final Duration duration;
  final VoidCallback? onEnd;

  late final AnimationController animationController;

  TimerWidgetController({
    this.duration = const Duration(minutes: 3),
    this.onEnd,
  }) {
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  void start() => animationController.forward();

  void stop() => animationController.stop();

  void reset() => animationController.reset();

  void restart() {
    reset();

    start();
  }

  void addListener(void Function() listener) => animationController.addListener(listener);

  void addStatusListener(void Function(AnimationStatus) listener) => animationController.addStatusListener(listener);

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
