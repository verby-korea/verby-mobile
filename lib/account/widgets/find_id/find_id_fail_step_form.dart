import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class FindIdFailStepForm extends StatelessWidget {
  const FindIdFailStepForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StepFormTitle(title: FindIdScreenStep.fail.title),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '입력하신 내용으로 가입된 내역이 없습니다.\n회원가입을 진행해 주세요.',
            style: Typography.body2.regular.setColorByPalette(
              color: Palette.gray80,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const Spacer(),
        VerbyButton.textButton(
          text: '회원가입하기',
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            AccountRoutes.registerRouteName,
            (route) => route.settings.name == AccountRoutes.loginRouteName,
            arguments: const RouteArguments(
              trasition: RouteTransitions.slideTop,
            ),
          ),
        ),
      ],
    );
  }
}
