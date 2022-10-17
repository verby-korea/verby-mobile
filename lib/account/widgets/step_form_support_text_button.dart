import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class StepFormSupportTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const StepFormSupportTextButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canTap = onTap != null;

    final TextStyle canTapTextStyle = Typography.caption1.regular //
        .setColorBySemanticColor(color: SemanticColor.text90)
        .setDecoration(decoration: TextDecoration.underline);
    final TextStyle canNotTapTextStyle = Typography.caption1.regular.setColorByPalette(
      color: Palette.gray70,
    );

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: canTap ? canTapTextStyle : canNotTapTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
