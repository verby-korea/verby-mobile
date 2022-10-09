import 'package:flutter/material.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyButtonStyle extends ButtonStyle {
  final double height;
  final double? width;

  final Palette defaultColor;
  final Palette pressedColor;
  final Palette disabledColor;

  final Palette childColor;
  final Palette pressedChildColor;
  final Palette disabledChildColor;

  final EdgeInsetsGeometry innerPadding;

  final TextStyle childTextStyle;

  final BorderSide borderSide;
  final BorderRadius borderRadius;

  VerbyButtonStyle({
    required this.height,
    this.width,
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
                return disabledColor;
              }

              return defaultColor;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Palette>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledChildColor;
              } else if (states.contains(MaterialState.pressed)) {
                return pressedChildColor;
              }

              return childColor;
            },
          ),
          overlayColor: MaterialStateProperty.all(pressedColor),
          padding: MaterialStateProperty.all(innerPadding),
          side: MaterialStateProperty.all(borderSide),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: borderSide,
              borderRadius: borderRadius,
            ),
          ),
          textStyle: MaterialStateProperty.all(childTextStyle),
          shadowColor: MaterialStateProperty.all(Palette.transparent),
          elevation: MaterialStateProperty.all(0.0),
          alignment: Alignment.center,
          animationDuration: kThemeAnimationDuration,
          enableFeedback: true,
          minimumSize: MaterialStateProperty.all(const Size(64, 36)),
          mouseCursor: MaterialStateProperty.resolveWith<MouseCursor>(
            (states) {
              if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;

              return SystemMouseCursors.click;
            },
          ),
          fixedSize: null,
          tapTargetSize: MaterialTapTargetSize.padded,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
}
