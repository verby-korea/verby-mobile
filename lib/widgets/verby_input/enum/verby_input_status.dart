import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum VerbyInputStatus {
  unfocus(
    // TODO: change to Unfocus input SemanticColor
    borderColor: SemanticColor.text50,
    textColor: SemanticColor.text30,
    backgroundColor: SemanticColor.transparent,
  ),
  focusValid(
    borderColor: SemanticColor.main70,
    textColor: SemanticColor.text90,
    backgroundColor: SemanticColor.transparent,
  ),
  inValid(
    borderColor: SemanticColor.main70,
    textColor: SemanticColor.text90,
    backgroundColor: SemanticColor.transparent,
  );

  final SemanticColor borderColor;
  final SemanticColor textColor;
  final SemanticColor backgroundColor;

  const VerbyInputStatus({
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
  });
}
