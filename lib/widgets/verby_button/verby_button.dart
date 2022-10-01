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
    double? height,
    SemanticColor? defaultColor,
    SemanticColor? pressedColor,
    SemanticColor? disabledColor,
    SemanticColor? childColor,
    SemanticColor? pressedChildColor,
    SemanticColor? disabledChildColor,
    EdgeInsetsGeometry? innerPadding,
    TextStyle? childTextStyle,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    InteractiveInkFeatureFactory splashFactory = InkRipple.splashFactory,
  }) {
    height ??= size.height;

    defaultColor ??= styleType.defaultColor;
    pressedColor ??= styleType.pressedColor;
    disabledColor ??= styleType.disabledColor;

    childColor ??= styleType.childColor;
    pressedChildColor ??= styleType.pressedChildColor;
    disabledChildColor ??= styleType.disabledChildColor;

    innerPadding ??= size.padding;

    childTextStyle ??= size.textStyle;

    borderSide ??= BorderSide.none;
    borderRadius ??= size.borderRadius;

    return VerbyButtonStyle(
      height: height,
      defaultColor: defaultColor,
      pressedColor: pressedColor,
      disabledColor: disabledColor,
      childColor: childColor,
      pressedChildColor: pressedChildColor,
      disabledChildColor: disabledChildColor,
      innerPadding: innerPadding,
      childTextStyle: childTextStyle,
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
      child: child,
    );

    return child;
  }
}
