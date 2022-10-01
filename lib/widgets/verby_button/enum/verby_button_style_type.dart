import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum VerbyButtonStyleType {
  primaryBlue(
    defaultColor: SemanticColor.main70,
    pressedColor: SemanticColor.main90,
    disabledColor: SemanticColor.background20,
    childColor: SemanticColor.text10,
    pressedChildColor: SemanticColor.text10,
    disabledChildColor: SemanticColor.text50,
  ),
  gray(
    defaultColor: SemanticColor.background20,
    pressedColor: SemanticColor.background20,
    disabledColor: SemanticColor.background20,
    childColor: SemanticColor.text90,
    pressedChildColor: SemanticColor.text90,
    disabledChildColor: SemanticColor.text50,
  );

  final SemanticColor defaultColor;
  final SemanticColor pressedColor;
  final SemanticColor disabledColor;

  final SemanticColor childColor;
  final SemanticColor pressedChildColor;
  final SemanticColor disabledChildColor;

  const VerbyButtonStyleType({
    required this.defaultColor,
    required this.pressedColor,
    required this.disabledColor,
    required this.childColor,
    required this.pressedChildColor,
    required this.disabledChildColor,
  });
}
