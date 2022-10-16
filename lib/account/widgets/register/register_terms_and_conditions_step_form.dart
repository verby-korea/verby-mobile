import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/account/account.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class RegisterTermsAndConditionsStepForm extends StatefulWidget {
  final void Function({required bool allowToMarketingNotification}) onSubmit;

  const RegisterTermsAndConditionsStepForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<RegisterTermsAndConditionsStepForm> createState() => _RegisterTermsAndConditionsStepFormState();
}

class _RegisterTermsAndConditionsStepFormState extends State<RegisterTermsAndConditionsStepForm> {
  bool agreedServiceTerms = false;
  bool agreedPrivacyTerms = false;
  bool agreedMarketingTerms = false;

  bool get canSubmit => agreedServiceTerms && agreedPrivacyTerms;

  @override
  Widget build(BuildContext context) {
    final bool isAgreedAll = agreedServiceTerms && agreedPrivacyTerms && agreedMarketingTerms;

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
                  title: RegisterScreenStep.termsAndConditions.title,
                ),
                const SizedBox(height: 18),
                _SelectAllTermsWidget(
                  isSelected: isAgreedAll,
                  onTap: () => onTapSelectAllTermsWidget(isAgreedAll: isAgreedAll),
                ),
                const SizedBox(height: 20),
                _TermsAndConditionsItem(
                  title: '(필수) 서비스 이용약관 동의',
                  content: '''*1. 본 약관은 공공누리에 게시하거나 기타의 방법으로 이용자 및 회원에게 공지함으로써 효력이 발생합니다.
                          
*2. 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현향약관과 함께 공공누리 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
                          
*3. 본 약관은 공공누리에 게시하거나 기타의 방법으로 이용자 및 회원에게 공지함으로써 효력이 발생합니다.
                          
*2. 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시
      
*1. 본 약관은 공공누리에 게시하거나 기타의 방법으로 이용자 및 회원에게 공지함으로써 효력이 발생합니다.
                          
*2. 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현향약관과 함께 공공누리 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
                          
*3. 본 약관은 공공누리에 게시하거나 기타의 방법으로 이용자 및 회원에게 공지함으로써 효력이 발생합니다.
                          
*2. 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시''',
                  isSelected: agreedServiceTerms,
                  onTap: () => setState(() {
                    agreedServiceTerms = !agreedServiceTerms;
                  }),
                ),
                const SizedBox(height: 20),
                _TermsAndConditionsItem(
                  title: '(필수) 개인정보 수집/이용 동의',
                  content: '',
                  isSelected: agreedPrivacyTerms,
                  onTap: () => setState(() {
                    agreedPrivacyTerms = !agreedPrivacyTerms;
                  }),
                ),
                const SizedBox(height: 20),
                _TermsAndConditionsItem(
                  title: '(선택) 개인정보 마케팅 이용 동의',
                  content: '',
                  isSelected: agreedMarketingTerms,
                  onTap: () => setState(() {
                    agreedMarketingTerms = !agreedMarketingTerms;
                  }),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        VerbyButton.textButton(
          text: '다음',
          onPressed: canSubmit ? () => widget.onSubmit(allowToMarketingNotification: agreedMarketingTerms) : null,
        ),
      ],
    );
  }

  void onTapSelectAllTermsWidget({required bool isAgreedAll}) {
    setState(() {
      agreedServiceTerms = isAgreedAll ? false : true;
      agreedPrivacyTerms = isAgreedAll ? false : true;
      agreedMarketingTerms = isAgreedAll ? false : true;
    });
  }
}

class _SelectAllTermsWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectAllTermsWidget({
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Palette selectedColor = SemanticColor.main70.palette;

    final Palette borderColor = isSelected ? selectedColor : SemanticColor.border40.palette;
    final Palette titleColor = isSelected ? selectedColor : SemanticColor.text90.palette;
    final Palette iconColor = isSelected ? selectedColor : Palette.gray30;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              '전체 약관에 동의합니다.',
              style: Typography.body1.medium.setColorByPalette(
                color: titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsAndConditionsItem extends StatefulWidget {
  final String title;
  final String content;

  final bool isSelected;

  final VoidCallback onTap;

  const _TermsAndConditionsItem({
    Key? key,
    required this.title,
    required this.content,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_TermsAndConditionsItem> createState() => __TermsAndConditionsItemState();
}

class __TermsAndConditionsItemState extends State<_TermsAndConditionsItem> {
  final ScrollController controller = ScrollController();
  bool isContentOpened = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.isSelected;

    final Palette checkBoxColor = isSelected ? SemanticColor.main70.palette : Palette.gray30;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_box,
                  size: 24,
                  color: checkBoxColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    style: Typography.body2.regular.setColorBySemanticColor(
                      color: SemanticColor.text90,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedRotation(
                  turns: isContentOpened ? -0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      isContentOpened = !isContentOpened;
                    }),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 24,
                      color: Palette.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isContentOpened)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: _TermsAndConditionsContentBox(
              content: widget.content,
              controller: controller,
            ),
          ),
      ],
    );
  }
}

class _TermsAndConditionsContentBox extends StatelessWidget {
  final String content;
  final ScrollController controller;

  const _TermsAndConditionsContentBox({
    Key? key,
    required this.content,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Radius scrollBarRadius = Radius.circular(2);

    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: Container(
        height: 168,
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        decoration: BoxDecoration(
          color: Palette.gray10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RawScrollbar(
          controller: controller,
          thickness: 4,
          thumbVisibility: true,
          thumbColor: Palette.gray40,
          radius: scrollBarRadius,
          trackVisibility: true,
          trackColor: Palette.gray20,
          trackRadius: scrollBarRadius,
          trackBorderColor: Palette.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: SingleChildScrollView(
              controller: controller,
              child: Text(
                content,
                style: Typography.caption2.medium.setColorByPalette(
                  color: Palette.gray80,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
