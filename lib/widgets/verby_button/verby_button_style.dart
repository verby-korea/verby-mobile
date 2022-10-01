import 'package:flutter/material.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyButtonStyle extends ButtonStyle {
  final double height;

  final SemanticColor defaultColor;
  final SemanticColor pressedColor;
  final SemanticColor disabledColor;

  final SemanticColor childColor;
  final SemanticColor pressedChildColor;
  final SemanticColor disabledChildColor;

  final EdgeInsetsGeometry innerPadding;

  final TextStyle childTextStyle;

  final BorderSide borderSide;
  final BorderRadius borderRadius;

  VerbyButtonStyle({
    required this.height,
    required this.defaultColor,
    required this.pressedColor,
    required this.disabledColor,
    required this.childColor,
    required this.pressedChildColor,
    required this.disabledChildColor,
    required this.innerPadding,
    required this.childTextStyle,
    this.borderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    super.splashFactory = InkRipple.splashFactory,
  }) : super(
          backgroundColor: MaterialStateProperty.resolveWith<Palette>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledColor.palette;
              }

              return defaultColor.palette;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Palette>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledChildColor.palette;
              } else if (states.contains(MaterialState.pressed)) {
                return pressedChildColor.palette;
              }

              return childColor.palette;
            },
          ),
          overlayColor: MaterialStateProperty.all(pressedColor.palette),
          padding: MaterialStateProperty.all(innerPadding),
          side: MaterialStateProperty.all(borderSide),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: borderSide,
              borderRadius: borderRadius,
            ),
          ),
          textStyle: MaterialStateProperty.all(childTextStyle),
          shadowColor: MaterialStateProperty.all(SemanticColor.transparent.palette),
          elevation: MaterialStateProperty.all(0.0),
          alignment: Alignment.center,
          animationDuration: kThemeAnimationDuration,
          enableFeedback: true,
          minimumSize: MaterialStateProperty.all(const Size(64, 36)),
          mouseCursor: MaterialStateProperty.resolveWith<MouseCursor>((states) {
            if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;

            return SystemMouseCursors.click;
          }),
          fixedSize: null,
          tapTargetSize: MaterialTapTargetSize.padded,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
}
