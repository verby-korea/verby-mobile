import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyDialogTitle extends StatelessWidget {
  final String title;
  final TextStyle? typography;

  const VerbyDialogTitle({
    super.key,
    required this.title,
    this.typography,
  });

  @override
  Widget build(BuildContext context) {
    final style = typography ?? Typography.h2.bold.setColorBySemanticColor(color: SemanticColor.main70);

    return Text(
      title,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
