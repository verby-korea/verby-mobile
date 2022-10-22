import 'package:either_dart/either.dart';
import 'package:flutter/material.dart' hide Typography;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/services/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

enum FindIdScreenStep {
  selfAuthentication(title: '아이디를 찾기 위해\n가입했던 정보를 입력해 주세요.'),
  success(title: '가입정보 안내'),
  fail(title: '가입 정보가 없습니다.');

  final String title;

  const FindIdScreenStep({
    required this.title,
  });
}

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({super.key});

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  late final String loginId;
  late final String createAt;

  FindIdScreenStep currentStep = FindIdScreenStep.selfAuthentication;

  @override
  Widget build(BuildContext context) {
    final Palette backgroundColor = SemanticColor.background10.palette;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          '아이디 찾기',
          style: Typography.body1.regular.setColorBySemanticColor(
            color: SemanticColor.text90,
          ),
        ),
        centerTitle: true,
        actions: [
          if (currentStep == FindIdScreenStep.selfAuthentication)
            GestureDetector(
              onTap: showCloseFindIdScreenDialog,
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
      case FindIdScreenStep.success:
        return FindIdSuccessStepForm(
          loginId: loginId,
          createdAt: createAt,
        );
      case FindIdScreenStep.fail:
        return const FindIdFailStepForm();
      case FindIdScreenStep.selfAuthentication:
      default:
        return FindIdSelfAuthenticationStepForm(
          onSumbit: submitOnSelfAuthenticationStep,
        );
    }
  }

  void submitOnSelfAuthenticationStep({required String token}) async {
    final AccountRepository accountRepository = AccountRepository();

    final Either<Failure, GetUsersLoginIdResponse> eitherResult = await accountRepository.findId(token: token);

    if (eitherResult.isLeft) {
      setState(() {
        currentStep = FindIdScreenStep.fail;
      });

      return;
    }

    loginId = eitherResult.right.loginId;
    createAt = DateFormat('yyyy.MM.dd').format(DateTime.parse(eitherResult.right.createdAt));

    setState(() {
      currentStep = FindIdScreenStep.success;
    });

    return;
  }

  void showCloseFindIdScreenDialog() {
    final NavigatorState navigatorState = Navigator.of(context);

    final VerbyDialog dialog = VerbyDialog.multipleButton(
      title: '아이디 찾기를 종료 하시겠습니까?',
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
