import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyDialogDescription extends StatelessWidget {
  final String description;
  final TextStyle? typography;

  const VerbyDialogDescription({
    super.key,
    required this.description,
    this.typography,
  });

  @override
  Widget build(BuildContext context) {
    final style = typography ?? Typography.body2.regular.setColorBySemanticColor(color: SemanticColor.text90);

    return Text(
      description,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
