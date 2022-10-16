import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class RegisterStepTitle extends StatelessWidget {
  final String title;

  const RegisterStepTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Typography.h2.bold.setColorBySemanticColor(
          color: SemanticColor.main70,
        ),
      ),
    );
  }
}
