import 'package:either_dart/either.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final FocusNode idFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  String? passwordInputErrorMessage;

  bool get canSubmit {
    final bool isIdValid = idController.text.isNotEmpty;
    final bool isPasswordValid = passwordController.text.isNotEmpty;

    return isIdValid && isPasswordValid && passwordInputErrorMessage == null;
  }

  @override
  void dispose() {
    idController.dispose();
    idFocus.dispose();

    passwordController.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Palette backgroundColor = SemanticColor.background10.palette;

    const Palette graySupportTextButtonColor = Palette.gray70;
    final Palette mainSupportTextButtonColor = SemanticColor.main70.palette;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            getScreenBottomPadding(context: context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 80),
                      Container(
                        width: double.infinity,
                        height: 82,
                        color: SemanticColor.main70.palette,
                        alignment: Alignment.center,
                        child: Text(
                          'Verby',
                          style: Typography.h1.bold.setColorByPalette(color: Palette.white),
                        ),
                      ),
                      const SizedBox(height: 40),
                      VerbyInput(
                        controller: idController,
                        focusNode: idFocus,
                        labelText: '아이디',
                        textInputAction: TextInputAction.next,
                        onChanged: (_) {
                          if (!mounted) return;

                          setState(() {});
                        },
                        hintText: '아이디를 입력해 주세요.',
                      ),
                      const SizedBox(height: 12),
                      VerbyInput(
                        controller: passwordController,
                        focusNode: passwordFocus,
                        labelText: '비밀번호',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) {
                          if (!mounted) return;
                          if (passwordInputErrorMessage != null) passwordInputErrorMessage = null;

                          setState(() {});
                        },
                        onSubmitted: (_) => onSubmit(),
                        validator: (_) => passwordInputErrorMessage,
                        obsecureText: true,
                        hintText: '비밀번호를 입력해 주세요.',
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _SupportTextButton(
                            text: '아이디 찾기',
                            textColor: graySupportTextButtonColor,
                            onTap: () {},
                          ),
                          _SupportTextButton(
                            text: '비밀번호 재설정',
                            textColor: graySupportTextButtonColor,
                            onTap: () {},
                          ),
                          _SupportTextButton(
                            text: '회원가입',
                            textColor: mainSupportTextButtonColor,
                            onTap: () => Navigator.of(context).pushNamed(
                              AccountRoutes.registerRouteName,
                              arguments: const RouteArguments(
                                trasition: RouteTransitions.slideTop,
                              ),
                            ),
                          ),
                        ].expand((element) => [const _SupportTextButtonDivider(), element]).skip(1).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              VerbyButton.textButton(
                text: '로그인',
                onPressed: canSubmit ? onSubmit : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    if (!canSubmit) return;

    final AccountRepository accountRepository = AccountRepository();

    final Either<Failure, void> eitherResult = await accountRepository.login(
      loginId: idController.text,
      password: passwordController.text,
    );

    if (eitherResult.isLeft) {
      setState(() {
        passwordInputErrorMessage = '아이디 또는 비밀번호를 확인 후 다시 시도해 주세요.';
      });

      return;
    }

    VerbyDialog.singleButton(
      title: '알림',
      description: '로그인에 성공하셨습니다 :)',
      buttonTitle: '확인',
      onPressed: () => Navigator.of(context).pop(),
    ).show();

    return;
  }
}

class _SupportTextButton extends StatelessWidget {
  final String text;
  final Palette textColor;
  final VoidCallback onTap;

  const _SupportTextButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Typography.caption1.medium.setColorByPalette(
          color: textColor,
        ),
      ),
    );
  }
}

class _SupportTextButtonDivider extends StatelessWidget {
  const _SupportTextButtonDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ' | ',
      style: Typography.caption1.medium.setColorByPalette(
        color: Palette.gray70,
      ),
    );
  }
}
