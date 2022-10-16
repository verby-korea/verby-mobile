import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/extensions/extensions.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class RegisterInformationStepFormData extends Equatable {
  final String name;
  final String phone;
  final int gender;
  final String birthday;
  final bool allowToMarketingNotification;
  final String token;

  const RegisterInformationStepFormData({
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.allowToMarketingNotification,
    required this.token,
  });

  @override
  List<Object> get props => [
        name,
        phone,
        gender,
        birthday,
        allowToMarketingNotification,
        token,
      ];
}

class RegisterInformationStepForm extends StatefulWidget {
  final RegisterInformationStepFormData data;
  final VoidCallback onSubmit;

  const RegisterInformationStepForm({
    super.key,
    required this.data,
    required this.onSubmit,
  });

  @override
  State<RegisterInformationStepForm> createState() => _RegisterInformationStepFormState();
}

class _RegisterInformationStepFormState extends State<RegisterInformationStepForm> {
  final AccountRepository accountRepository = AccountRepository();

  final TextEditingController idController = TextEditingController();
  final FocusNode idFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  final TextEditingController checkPasswordController = TextEditingController();
  final FocusNode checkPasswordFocus = FocusNode();

  String? idInputErrorMessage;

  bool isIdNotDuplicated = false;

  bool get isIdValid => idController.text.isNotEmpty;

  bool get canSubmit {
    final String password = passwordController.text;

    final bool isIdValidFinal = isIdValid && idInputErrorMessage == null && isIdNotDuplicated;
    final bool isPasswordValid = password.isValidPassword;
    final bool isCheckPasswordValid = password == checkPasswordController.text;

    return isIdValidFinal && isPasswordValid && isCheckPasswordValid;
  }

  @override
  void dispose() {
    idController.dispose();
    idFocus.dispose();

    passwordController.dispose();
    passwordFocus.dispose();

    checkPasswordController.dispose();
    checkPasswordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StepFormTitle(
                  title: RegisterScreenStep.information.title,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: idInputErrorMessage == null ? CrossAxisAlignment.end : CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: VerbyInput(
                        controller: idController,
                        focusNode: idFocus,
                        labelText: '아이디',
                        textInputAction: TextInputAction.continueAction,
                        onChanged: (_) {
                          if (!mounted) return;
                          if (idInputErrorMessage != null) idInputErrorMessage = null;
                          // TODO: 아이디 중복 확인 api가 변경되면 주석 해제
                          // if (isIdNotDuplicated) isIdNotDuplicated = false;

                          setState(() {});
                        },
                        onSubmitted: (_) => checkDuplicateLoginId(),
                        validator: (_) => idInputErrorMessage,
                        autoFocus: true,
                        hintText: '아이디를 입력해 주세요.',
                      ),
                    ),
                    const SizedBox(width: 8),
                    VerbyButton.textButton(
                      text: '중복확인',
                      style: VerbyButton.styleFrom(
                        height: 54,
                        buttonWidth: VerbyButtonWidth.contract,
                      ),
                      onPressed: isIdValid ? checkDuplicateLoginId : null,
                    ),
                  ],
                ),
                if (isIdNotDuplicated) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '사용 가능한 아이디입니다.',
                        style: Typography.caption1.regular.setColorBySemanticColor(
                          color: SemanticColor.main70,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                VerbyInput(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  labelText: '비밀번호',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (_) {
                    if (!mounted) return;

                    setState(() {});
                  },
                  hintText: '비밀번호를 입력해 주세요.',
                  obsecureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: PasswordValidatorWidget(password: passwordController.text),
                ),
                const SizedBox(height: 12),
                VerbyInput(
                  controller: checkPasswordController,
                  focusNode: checkPasswordFocus,
                  labelText: '비밀번호 확인',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (_) {
                    if (!mounted) return;

                    setState(() {});
                  },
                  onSubmitted: (_) => onSubmit(),
                  hintText: '한번 더 입력해 주세요.',
                  obsecureText: true,
                  validator: (text) {
                    if (text.isEmpty) return null;

                    final bool isValid = text == passwordController.text;
                    if (isValid) return null;

                    return '비밀번호가 일치하지 않습니다.';
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        VerbyButton.textButton(
          text: '가입하기',
          onPressed: canSubmit ? onSubmit : null,
        ),
      ],
    );
  }

  void checkDuplicateLoginId() async {
    if (!isIdValid) return;

    // TODO: Api 변경되면 변경된 Api에 맞춰서 작업해야함

    // final String loginId = idController.text;

    // final Either<Failure, void> eitherResult = await accountRepository.checkDuplicateLoginId(
    //   loginId: loginId,
    // );

    // if (eitherResult.isLeft) {
    //   setState(() {
    //     idInputErrorMessage = eitherResult.left.message;
    //     isIdNotDuplicated = false;
    //   });

    //   return;
    // }

    setState(() {
      isIdNotDuplicated = true;
    });

    passwordFocus.requestFocus();
  }

  void onSubmit() async {
    if (!canSubmit) return;

    final RegisterInformationStepFormData data = widget.data;

    final Either<Failure, String> eitherResult = await accountRepository.register(
      loginId: idController.text,
      password: passwordController.text,
      name: data.name,
      phone: data.phone,
      gender: data.gender,
      birthday: '2002-11-08',
      // TODO: Api 생년월일 migration 완료되면 변경
      // birthday: data.birthday,
      allowToMarketingNotification: data.allowToMarketingNotification,
      token: data.token,
    );

    if (eitherResult.isLeft) {
      VerbyDialog.singleButton(
        title: '회원가입 중 문제가 발생했습니다',
        description: eitherResult.left.message,
        buttonTitle: '확인',
        onPressed: () {
          if (!mounted) return;

          Navigator.of(context).pop();
        },
      ).show();

      return;
    }

    widget.onSubmit();

    return;
  }
}
