import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/extensions/extensions.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class PasswordValidatorWidget extends StatelessWidget {
  final String password;

  const PasswordValidatorWidget({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _PasswordValidatorItem(
          title: '영문/숫자',
          isValid: password.hasAlphabet && password.hasNum,
        ),
        const SizedBox(width: 8),
        _PasswordValidatorItem(
          title: '특수문자',
          isValid: password.hasSpecialCharacter,
        ),
        const SizedBox(width: 8),
        _PasswordValidatorItem(
          title: '10자리이상',
          isValid: password.length >= 10,
        ),
      ],
    );
  }
}

class _PasswordValidatorItem extends StatelessWidget {
  final String title;
  final bool isValid;

  const _PasswordValidatorItem({
    Key? key,
    required this.title,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Palette inValidColor = Palette.gray50;
    final Palette validColor = SemanticColor.main70.palette;

    final Palette color = isValid ? validColor : inValidColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.check,
          size: 24,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          title,
          style: Typography.caption1.medium.setColorByPalette(color: color),
        ),
      ],
    );
  }
}
