import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum PasswordResetScreenStep {
  selfAuthentication(title: '비밀번호 재설정을 위해\n가입했던 정보를 입력해 주세요.'),
  reset(title: '비밀번호를 재설정 해주세요.'),
  success(title: '비밀번호 재설정을 완료하였습니다.');

  final String title;

  const PasswordResetScreenStep({
    required this.title,
  });
}

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  late final String token;

  PasswordResetScreenStep currentStep = PasswordResetScreenStep.selfAuthentication;

  @override
  Widget build(BuildContext context) {
    final Palette backgroundColor = SemanticColor.background10.palette;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          '비밀번호 재설정',
          style: Typography.body1.regular.setColorBySemanticColor(
            color: SemanticColor.text90,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: showClosePasswordResetScreenDialog,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(
                Icons.close,
                size: 24,
                color: Palette.gray90,
              ),
            ),
          ),
        ],
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            18,
            20,
            getScreenBottomPadding(context: context),
          ),
          child: buildStepForm(),
        ),
      ),
    );
  }

  Widget buildStepForm() {
    switch (currentStep) {
      case PasswordResetScreenStep.reset:
        return PasswordResetResetStepForm(
          data: PasswordResetResetStepFormData(token: token),
          onSubmit: submitOnResetStep,
        );
      case PasswordResetScreenStep.success:
        return const PasswordResetSuccessStepForm();
      case PasswordResetScreenStep.selfAuthentication:
      default:
        return PasswordResetSelfAuthenticationStepForm(
          onSubmit: submitOnSelfAuthenticationStep,
        );
    }
  }

  void submitOnSelfAuthenticationStep({required String token}) {
    this.token = token;

    setState(() {
      currentStep = PasswordResetScreenStep.reset;
    });

    return;
  }

  void submitOnResetStep() {
    setState(() {
      currentStep = PasswordResetScreenStep.success;
    });

    return;
  }

  void showClosePasswordResetScreenDialog() {
    final NavigatorState navigatorState = Navigator.of(context);

    if (currentStep == PasswordResetScreenStep.success) {
      return popUntilToLoginScreen();
    }

    final VerbyDialog dialog = VerbyDialog.multipleButton(
      title: '비밀번호 재설정을 종료 하시겠습니까?',
      description: '종료할 경우 기입된 내용은\n저장되지 않습니다.',
      leftButtonTitle: '취소',
      leftButtonOnPressed: navigatorState.pop,
      rightButtonTitle: '확인',
      rightButtonOnPressed: popUntilToLoginScreen,
    );

    dialog.show();

    return;
  }

  void popUntilToLoginScreen() {
    final NavigatorState navigatorState = Navigator.of(context);

    navigatorState.popUntil(
      (route) => route.settings.name == AccountRoutes.loginRouteName,
    );

    return;
  }
}
