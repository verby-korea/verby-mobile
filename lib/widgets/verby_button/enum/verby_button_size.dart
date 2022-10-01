import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum VerbyButtonSize {
  large(
    height: 48,
    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );

  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const VerbyButtonSize({
    required this.height,
    required this.padding,
    required this.borderRadius,
  });
}

extension VerbyButtonSizeExtension on VerbyButtonSize {
  TextStyle get textStyle {
    switch (this) {
      case VerbyButtonSize.large:
      default:
        return Typography.body2.regular;
    }
  }
}
