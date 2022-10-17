import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/screen_helper.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum RegisterScreenStep {
  termsAndConditions(
    title: 'STEP.1 약관 동의',
    progressPercentage: 0.33,
  ),
  selfAuthentication(
    title: 'STEP.2 본인인증',
    progressPercentage: 0.66,
  ),
  information(
    title: 'STEP.3 개인정보',
    progressPercentage: 1.0,
  ),
  complete(
    title: '회원가입이 완료됐습니다.',
    progressPercentage: 0.0,
  );

  final String title;
  final double progressPercentage;

  const RegisterScreenStep({
    required this.title,
    required this.progressPercentage,
  });
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // callback from RegisterScreenStep.termsAndConditions
  late final bool allowToMarketingNotification;

  // callback from RegisterScreenStep.selfAuthentication
  late final String name;
  late final String birthday;
  late final String phone;
  late final String token;
  late final int gender;

  RegisterScreenStep currentStep = RegisterScreenStep.termsAndConditions;

  bool get isCompleteStep => currentStep == RegisterScreenStep.complete;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final double screenWidth = mediaQuery.size.width;
    const double progressWidgetHeight = 8.0;

    final Palette backgroundColor = SemanticColor.background10.palette;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: Typography.body1.regular.setColorBySemanticColor(
            color: SemanticColor.text90,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!isCompleteStep)
            GestureDetector(
              onTap: showCloseRegisterScreenDialog,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (!isCompleteStep)
              Stack(
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: progressWidgetHeight,
                    color: Palette.gray5,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: screenWidth * currentStep.progressPercentage,
                    height: progressWidgetHeight,
                    color: SemanticColor.main70.palette,
                  ),
                ],
              ),
            Expanded(
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
          ],
        ),
      ),
    );
  }

  Widget buildStepForm() {
    switch (currentStep) {
      case RegisterScreenStep.selfAuthentication:
        return RegisterSelfAuthenticationStepForm(
          onSubmit: submitOnSelfAuthenticationStep,
        );
      case RegisterScreenStep.information:
        return RegisterInformationStepForm(
          data: RegisterInformationStepFormData(
            name: name,
            phone: phone,
            gender: gender,
            birthday: birthday,
            allowToMarketingNotification: allowToMarketingNotification,
            token: token,
          ),
          onSubmit: submitOnInformationStep,
        );
      case RegisterScreenStep.complete:
        return const RegisterCompleteStepForm();
      case RegisterScreenStep.termsAndConditions:
      default:
        return RegisterTermsAndConditionsStepForm(
          onSubmit: submitOnTermsAndConditionsStep,
        );
    }
  }

  void submitOnTermsAndConditionsStep({required bool allowToMarketingNotification}) {
    this.allowToMarketingNotification = allowToMarketingNotification;

    setState(() {
      currentStep = RegisterScreenStep.selfAuthentication;
    });
  }

  void submitOnSelfAuthenticationStep({
    required String name,
    required String birthday,
    required String phone,
    required String token,
    required int gender,
  }) {
    this.name = name;
    this.birthday = birthday;
    this.phone = phone;
    this.token = token;
    this.gender = gender;

    setState(() {
      currentStep = RegisterScreenStep.information;
    });
  }

  void submitOnInformationStep() {
    setState(() {
      currentStep = RegisterScreenStep.complete;
    });
  }

  void showCloseRegisterScreenDialog() {
    final NavigatorState navigatorState = Navigator.of(context);

    final VerbyDialog dialog = VerbyDialog.multipleButton(
      title: '회원가입을 종료 하시겠습니까?',
      description: '종료할 경우 기입된 내용은\n저장되지 않습니다.',
      leftButtonTitle: '취소',
      leftButtonOnPressed: navigatorState.pop,
      rightButtonTitle: '확인',
      rightButtonOnPressed: () => navigatorState.popUntil(
        (route) => route.settings.name == AccountRoutes.loginRouteName,
      ),
    );

    dialog.show();

    return;
  }
}
