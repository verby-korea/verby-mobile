import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum VerbyInputStatus {
  unfocus(
    borderColor: SemanticColor.text50,
    textColor: SemanticColor.text30,
  ),
  focusValid(
    borderColor: SemanticColor.main70,
    textColor: SemanticColor.text90,
  ),
  inValid(
    borderColor: SemanticColor.main70,
    textColor: SemanticColor.text90,
  );

  final SemanticColor borderColor;
  final SemanticColor textColor;

  const VerbyInputStatus({
    required this.borderColor,
    required this.textColor,
  });
}
