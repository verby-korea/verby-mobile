import 'package:flutter/material.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyButton extends StatelessWidget {
  final Widget child;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;

  final MaterialStatesController? statesController;

  final VerbyButtonStyle? style;

  final FocusNode? focusNode;
  final bool autoFocus;

  final Clip clipBehavior;

  const VerbyButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.statesController,
    this.style,
    this.focusNode,
    this.autoFocus = false,
    this.clipBehavior = Clip.antiAlias,
  });

  factory VerbyButton.textButton({
    Key? key,
    required String text,
    TextStyle? textStyle,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    MaterialStatesController? statesController,
    VerbyButtonStyle? style,
    FocusNode? focusNode,
    bool autoFocus = false,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    style ??= styleFrom();

    return VerbyButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      statesController: statesController,
      style: style,
      focusNode: focusNode,
      autoFocus: autoFocus,
      clipBehavior: clipBehavior,
      child: Text(
        text,
        style: textStyle ?? style.childTextStyle,
      ),
    );
  }

  static VerbyButtonStyle styleFrom({
    VerbyButtonSize size = VerbyButtonSize.large,
    VerbyButtonStyleType styleType = VerbyButtonStyleType.primaryBlue,
    VerbyButtonWidth buttonWidth = VerbyButtonWidth.expand,
    double? height,
    double? width,
    Palette? defaultColor,
    Palette? pressedColor,
    Palette? disabledColor,
    Palette? childColor,
    Palette? pressedChildColor,
    Palette? disabledChildColor,
    EdgeInsetsGeometry? innerPadding,
    TextStyle? childTextStyle,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    InteractiveInkFeatureFactory splashFactory = InkRipple.splashFactory,
  }) {
    height ??= size.height;
    width ??= buttonWidth.value;

    defaultColor ??= styleType.defaultColor.palette;
    pressedColor ??= styleType.pressedColor.palette;
    disabledColor ??= styleType.disabledColor.palette;

    childColor ??= styleType.childColor.palette;
    pressedChildColor ??= styleType.pressedChildColor.palette;
    disabledChildColor ??= styleType.disabledChildColor.palette;

    innerPadding ??= size.padding;

    childTextStyle ??= size.textStyle;

    borderSide ??= BorderSide.none;
    borderRadius ??= size.borderRadius;

    return VerbyButtonStyle(
      height: height,
      width: width,
      defaultColor: defaultColor,
      pressedColor: pressedColor,
      disabledColor: disabledColor,
      childColor: childColor,
      pressedChildColor: pressedChildColor,
      disabledChildColor: disabledChildColor,
      innerPadding: innerPadding,
      childTextStyle: childTextStyle,
      borderSide: borderSide,
      borderRadius: borderRadius,
      splashFactory: splashFactory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final VerbyButtonStyle style = this.style ?? styleFrom();

    Widget child = ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      statesController: statesController,
      style: style,
      focusNode: focusNode,
      autofocus: autoFocus,
      clipBehavior: clipBehavior,
      child: this.child,
    );

    child = SizedBox(
      height: style.height,
      width: style.width,
      child: child,
    );

    return child;
  }
}
