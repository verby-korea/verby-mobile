import 'package:flutter/material.dart' hide Typography;
import 'package:flutter/scheduler.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

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

class TimerWidget extends StatefulWidget {
  final TimerWidgetController controller;
  final TextStyle? timerStyle;

  const TimerWidget({
    super.key,
    required this.controller,
    this.timerStyle,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late final Animation<Duration> animation;

  @override
  void initState() {
    super.initState();

    final TimerWidgetController controller = widget.controller;

    controller.addListener(() => setState(() {}));

    controller.addStatusListener(
      (status) {
        if (status != AnimationStatus.completed) return;

        final VoidCallback? onEnd = controller.onEnd;
        if (onEnd != null) onEnd();
      },
    );

    animation = Tween<Duration>(
      begin: controller.duration,
      end: Duration.zero,
    ).animate(controller.animationController);

    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('mm:ss 남음');
    final DateTime time = DateTime.fromMillisecondsSinceEpoch(animation.value.inMilliseconds);

    final TextStyle timerStyle = widget.timerStyle ??
        Typography.caption1.regular.setColorBySemanticColor(
          color: SemanticColor.subCaution,
        );

    return Text(
      formatter.format(time),
      style: timerStyle,
    );
  }
}
