import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class RegisterSelfAuthenticationStepForm extends StatefulWidget {
  final void Function({
    required String name,
    required String birthday,
    required String phone,
    required String token,
    required int gender,
  }) onSubmit;

  const RegisterSelfAuthenticationStepForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<RegisterSelfAuthenticationStepForm> createState() => _RegisterSelfAuthenticationStepFormState();
}

class _RegisterSelfAuthenticationStepFormState extends State<RegisterSelfAuthenticationStepForm> {
  final AccountRepository accountRepository = AccountRepository();

  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();

  final TextEditingController birthdayController = TextEditingController();
  final FocusNode birthdayFocus = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  final TextEditingController certificationNumberController = TextEditingController();
  final FocusNode certificationNumberFocus = FocusNode();

  late final TimerWidgetController timerWidgetController = TimerWidgetController(
    onEnd: () {
      setState(() {
        certificationNumberInputErrorMessage = '인증번호가 일치하지 않습니다. 다시 확인해 주세요.';
      });
    },
  );

  final ScrollController scrollController = ScrollController();

  String? phoneInputErrorMessage;
  String? certificationNumberInputErrorMessage;

  bool isSentCertificationNumber = false;

  bool get canSubmit {
    final bool isNameValid = nameController.text.isNotEmpty;
    final bool isBirthdayValid = birthdayController.text.length == 14;
    final bool isPhoneValid = phoneController.text.length == 13;

    if (isSentCertificationNumber) {
      final bool isCertificationNumberValid = certificationNumberController.text.length == 4;

      return isNameValid && isBirthdayValid && isPhoneValid && isCertificationNumberValid;
    }

    return isNameValid && isBirthdayValid && isPhoneValid;
  }

  String get submitButtonTitle {
    if (isSentCertificationNumber) return '인증하기';

    return '인증번호 전송';
  }

  String get supportTextButtonTitle {
    if (isSentCertificationNumber) return '인증번호 재전송';

    return '정보를 잘못 입력하신 경우\n인증번호가 전송되지 않을 수 있습니다.';
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocus.dispose();

    birthdayController.dispose();
    birthdayFocus.dispose();

    phoneController.dispose();
    phoneFocus.dispose();

    certificationNumberController.dispose();
    certificationNumberFocus.dispose();

    timerWidgetController.animationController.dispose();

    scrollController.dispose();

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
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StepFormTitle(
                  title: RegisterScreenStep.selfAuthentication.title,
                ),
                const SizedBox(height: 18),
                VerbyInput(
                  controller: nameController,
                  focusNode: nameFocus,
                  labelText: '이름',
                  autoFocus: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) {
                    if (!mounted) return;

                    setState(() {});
                  },
                  hintText: '이름을 입력해 주세요.',
                ),
                const SizedBox(height: 12),
                VerbyInput(
                  controller: birthdayController,
                  focusNode: birthdayFocus,
                  labelText: '생년월일',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    if (!mounted) return;

                    setState(() {});
                  },
                  onUnFocus: () {
                    if (!mounted) return;

                    final String birthday = birthdayController.text;

                    if (birthday.length >= 8) {
                      final String maskedBirthday = '${birthday.replaceAll('*', '')}******';

                      birthdayController.text = maskedBirthday;
                      birthdayController.selection = TextSelection.collapsed(
                        offset: maskedBirthday.length,
                      );
                    }

                    setState(() {});
                  },
                  inputFormatters: [
                    MaskedTextInputFormatter(
                      masks: <String>['xxxxxx-x'],
                      separator: '-',
                    ),
                  ],
                  hintText: '생년월일 6자리와 뒤 1자리를 입력해 주세요.',
                ),
                const SizedBox(height: 12),
                VerbyInput(
                  controller: phoneController,
                  focusNode: phoneFocus,
                  labelText: '전화번호',
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {
                    if (!mounted) return;
                    if (phoneInputErrorMessage != null) phoneInputErrorMessage = null;

                    setState(() {});
                  },
                  onSubmitted: (_) => sendCertificationNumber(),
                  validator: (_) => phoneInputErrorMessage,
                  inputFormatters: [
                    MaskedTextInputFormatter(
                      masks: <String>['xxx-xxxx-xxxx'],
                      separator: '-',
                    ),
                  ],
                  hintText: '\'-\'를 제외한 전화번호를 입력해 주세요.',
                ),
                if (isSentCertificationNumber) ...[
                  const SizedBox(height: 12),
                  VerbyInput(
                    controller: certificationNumberController,
                    focusNode: certificationNumberFocus,
                    labelText: '인증번호',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      if (!mounted) return;
                      if (certificationNumberInputErrorMessage != null) certificationNumberInputErrorMessage = null;

                      setState(() {});
                    },
                    onSubmitted: (_) => resolveCertificationNumber(),
                    validator: (_) => certificationNumberInputErrorMessage,
                    maxLength: 4,
                    hintText: '인증번호를 입력해 주세요.',
                    suffixWidget: TimerWidget(controller: timerWidgetController),
                  ),
                ],
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        _SupportTextButton(
          text: supportTextButtonTitle,
          onTap: isSentCertificationNumber ? reSendCertificationNumber : null,
        ),
        const SizedBox(height: 8),
        VerbyButton.textButton(
          text: submitButtonTitle,
          onPressed: canSubmit ? onPressedSubmitButton : null,
        ),
      ],
    );
  }

  void onPressedSubmitButton() async {
    if (!canSubmit) return;

    if (isSentCertificationNumber) {
      resolveCertificationNumber();

      return;
    }

    sendCertificationNumber();
  }

  void sendCertificationNumber() async {
    if (!canSubmit) return;

    // TODO: 전화번호 중복확인 후 Dialog 보여주는 작업

    final String phone = phoneController.text.replaceAll('-', '');

    final Either<Failure, void> eitherResult = await accountRepository.issueCertificationNumberByPhone(phone: phone);

    if (eitherResult.isLeft) {
      setState(() {
        phoneInputErrorMessage = eitherResult.left.message;
      });

      scrollController.jumpTo(scrollController.position.maxScrollExtent);

      return;
    }

    setState(() {
      isSentCertificationNumber = true;
    });

    certificationNumberFocus.requestFocus();
  }

  void reSendCertificationNumber() async {
    sendCertificationNumber();

    timerWidgetController.restart();
  }

  void resolveCertificationNumber() async {
    if (!canSubmit) return;

    final String phone = phoneController.text.replaceAll('-', '');

    final Either<Failure, String> eitherResult = await accountRepository.resolveCertificationNumber(
      phone: phone,
      certificationNumber: int.parse(certificationNumberController.text),
    );

    if (eitherResult.isLeft) {
      final Failure failure = eitherResult.left;

      String errorMessage = failure.message;

      if (failure is ApiCallFailure) {
        final ErrorCode code = failure.code;
        if (code == ErrorCode.auth001) {
          errorMessage = '인증번호가 일치하지 않습니다. 다시 확인해 주세요.';
        }
      }

      setState(() {
        certificationNumberInputErrorMessage = errorMessage;
      });

      scrollController.jumpTo(scrollController.position.maxScrollExtent);

      timerWidgetController.stop();

      return;
    }

    final List<String> splitBirthday = birthdayController.text.replaceAll('*', '').split('-');

    final String birthday = splitBirthday.first;
    final int gender = int.parse(splitBirthday.last);

    widget.onSubmit(
      name: nameController.text,
      phone: phone,
      birthday: birthday,
      token: eitherResult.right,
      gender: gender,
    );

    return;
  }
}

class _SupportTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _SupportTextButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool canTap = onTap != null;

    final TextStyle canTapTextStyle = Typography.caption1.regular //
        .setColorBySemanticColor(color: SemanticColor.text90)
        .setDecoration(decoration: TextDecoration.underline);
    final TextStyle canNotTapTextStyle = Typography.caption1.regular.setColorByPalette(
      color: Palette.gray70,
    );

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: canTap ? canTapTextStyle : canNotTapTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
