import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class RegisterCompleteStepForm extends StatelessWidget {
  const RegisterCompleteStepForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StepFormTitle(
          title: RegisterScreenStep.complete.title,
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '로그인 이후 사용가능합니다.',
            style: Typography.body2.regular.setColorByPalette(
              color: Palette.gray80,
            ),
          ),
        ),
        const Spacer(),
        VerbyButton.textButton(
          text: '로그인',
          onPressed: () => Navigator.of(context).popUntil(
            (route) => route.settings.name == AccountRoutes.loginRouteName,
          ),
        ),
      ],
    );
  }
}
