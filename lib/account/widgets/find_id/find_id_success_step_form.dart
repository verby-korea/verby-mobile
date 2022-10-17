import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class FindIdSuccessStepForm extends StatelessWidget {
  final String loginId;
  final String createdAt;

  const FindIdSuccessStepForm({
    super.key,
    required this.loginId,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StepFormTitle(title: FindIdScreenStep.success.title),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '지금 바로 로그인을 진행해 주세요.',
            style: Typography.body2.regular.setColorByPalette(
              color: Palette.gray80,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Palette.gray5,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                loginId,
                style: Typography.sub1.bold.setColorBySemanticColor(
                  color: SemanticColor.text90,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$createdAt 가입',
                style: Typography.caption2.regular.setColorByPalette(
                  color: Palette.gray70,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        StepFormSupportTextButton(
          text: '비밀번호 찾기',
          onTap: () => navigator.pushNamedAndRemoveUntil(
            // TODO: 비밀번호 찾기 화면 Routes로 변경
            AccountRoutes.registerRouteName,
            (route) => route.settings.name == AccountRoutes.loginRouteName,
            arguments: const RouteArguments(
              trasition: RouteTransitions.slideTop,
            ),
          ),
        ),
        const SizedBox(height: 8),
        VerbyButton.textButton(
          text: '로그인하기',
          onPressed: () => navigator.popUntil(
            (route) => route.settings.name == AccountRoutes.loginRouteName,
          ),
        ),
      ],
    );
  }
}
