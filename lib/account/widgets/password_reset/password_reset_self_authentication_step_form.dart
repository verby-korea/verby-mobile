import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';

class PasswordResetSelfAuthenticationStepForm extends StatefulWidget {
  final void Function({required String token}) onSubmit;

  const PasswordResetSelfAuthenticationStepForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PasswordResetSelfAuthenticationStepForm> createState() => _PasswordResetSelfAuthenticationStepFormState();
}

class _PasswordResetSelfAuthenticationStepFormState extends State<PasswordResetSelfAuthenticationStepForm> {
  final AccountRepository accountRepository = AccountRepository();

  final TextEditingController idController = TextEditingController();
  final FocusNode idFocus = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  final TextEditingController certificationNumberController = TextEditingController();
  final FocusNode certificationNumberFocus = FocusNode();

  late final TimerWidgetController timerWidgetController = TimerWidgetController(
    onEnd: () {
      setState(() {
        certificationNumberInputErrorMessage = '입력 시간이 초과되었습니다. 재전송 버튼을 눌러주세요.';
      });
    },
  );

  final ScrollController scrollController = ScrollController();

  String? idInputErrorMessage;
  String? phoneInputErrorMessage;
  String? certificationNumberInputErrorMessage;

  bool isSentCertificationNumber = false;

  String get submitButtonTitle {
    if (isSentCertificationNumber) return '인증하기';

    return '인증번호 전송';
  }

  String get supportTextButtonTitle {
    if (isSentCertificationNumber) return '인증번호 재전송';

    return '정보를 잘못 입력하신 경우\n인증번호가 전송되지 않을 수 있습니다.';
  }

  bool get canSubmit {
    final bool isIdValid = idController.text.isNotEmpty && idInputErrorMessage == null;
    final bool isPhoneValid = phoneController.text.length == 13 && phoneInputErrorMessage == null;

    if (isSentCertificationNumber) {
      final bool isCertificationNumberValid = certificationNumberController.text.length == 4;

      return isIdValid && isPhoneValid && isCertificationNumberValid && certificationNumberInputErrorMessage == null;
    }

    return isIdValid && isPhoneValid;
  }

  @override
  void dispose() {
    idController.dispose();
    idFocus.dispose();

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
                  title: PasswordResetScreenStep.selfAuthentication.title,
                ),
                const SizedBox(height: 18),
                VerbyInput(
                  controller: idController,
                  focusNode: idFocus,
                  labelText: '아이디',
                  textInputAction: TextInputAction.next,
                  onChanged: (_) {
                    if (!mounted) return;
                    if (idInputErrorMessage != null) idInputErrorMessage = null;
                    if (certificationNumberController.text.isNotEmpty) certificationNumberController.text = '';

                    setState(() {});
                  },
                  validator: (_) => idInputErrorMessage,
                  hintText: '가입한 아이디를 입력해 주세요.',
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
                    if (certificationNumberController.text.isNotEmpty) certificationNumberController.text = '';

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
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        StepFormSupportTextButton(
          text: supportTextButtonTitle,
          onTap: isSentCertificationNumber ? reSendCertificationNumber : null,
        ),
        const SizedBox(height: 8),
        VerbyButton.textButton(
          text: submitButtonTitle,
          onPressed: canSubmit ? onSubmit : null,
        ),
      ],
    );
  }

  void onSubmit() {
    if (!canSubmit) return;

    if (isSentCertificationNumber) {
      resolveCertificationNumber();

      return;
    }

    sendCertificationNumber();
  }

  void sendCertificationNumber() async {
    if (!canSubmit) return;

    final String id = idController.text;

    final Either<Failure, void> duplicatedIdResult = await accountRepository.checkDuplicateLoginId(loginId: id);

    if (duplicatedIdResult.isLeft) {
      setState(() {
        idInputErrorMessage = '가입되지 않은 아이디 입니다.';
      });

      return;
    }

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

      return;
    }

    final String token = eitherResult.right;

    widget.onSubmit(token: token);

    return;
  }
}
