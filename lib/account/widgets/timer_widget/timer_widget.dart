import 'package:flutter/material.dart' hide Typography;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

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
