import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/extensions/extensions.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';

class PasswordResetResetStepFormData extends Equatable {
  final String token;

  const PasswordResetResetStepFormData({required this.token});

  @override
  List<Object> get props => [token];
}

class PasswordResetResetStepForm extends StatefulWidget {
  final PasswordResetResetStepFormData data;
  final VoidCallback onSubmit;

  const PasswordResetResetStepForm({
    super.key,
    required this.data,
    required this.onSubmit,
  });

  @override
  State<PasswordResetResetStepForm> createState() => _PasswordResetResetStepFormState();
}

class _PasswordResetResetStepFormState extends State<PasswordResetResetStepForm> {
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  final TextEditingController checkPasswordController = TextEditingController();
  final FocusNode checkPasswordFocus = FocusNode();

  String? checkPasswordInputErrorMessage;

  bool get canSubmit {
    final String password = passwordController.text;

    final bool isPasswordValid = password.isValidPassword;
    final bool isCheckPasswordValid = password == checkPasswordController.text;

    return isPasswordValid && isCheckPasswordValid;
  }

  @override
  void dispose() {
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
                StepFormTitle(title: PasswordResetScreenStep.reset.title),
                const SizedBox(height: 18),
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
                    if (checkPasswordInputErrorMessage != null) return checkPasswordInputErrorMessage;

                    if (text.isEmpty) return null;

                    final bool isValid = text == passwordController.text;
                    if (isValid) return null;

                    return '비밀번호가 일치하지 않습니다.';
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        VerbyButton.textButton(
          text: '변경하기',
          onPressed: canSubmit ? onSubmit : null,
        ),
      ],
    );
  }

  void onSubmit() async {
    if (!canSubmit) return;

    final Either<Failure, void> resetPasswordResult = await AccountRepository().resetPassword(
      token: widget.data.token,
      password: passwordController.text,
    );

    if (resetPasswordResult.isLeft) {
      setState(() {
        checkPasswordInputErrorMessage = resetPasswordResult.left.message;
      });

      return;
    }

    widget.onSubmit();

    return;
  }
}
