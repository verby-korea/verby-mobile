import 'package:flutter/material.dart' hide Typography;
import 'package:flutter/services.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  final String? labelText;

  final bool autoFocus;
  final bool autoCorrect;
  final bool obsecureText;

  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;

  final void Function()? onFocus;
  final void Function()? onUnFocus;

  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  /// validator return error text on InValid Status
  final String? Function(String text)? validator;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  final bool readOnly;

  final EdgeInsets padding;
  final String? hintText;
  final Widget? suffixWidget;

  VerbyInput({
    super.key,
    TextEditingController? controller,
    FocusNode? focusNode,
    this.labelText,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.obsecureText = false,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.onFocus,
    this.onUnFocus,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 14),
    this.hintText,
    this.suffixWidget,
  })  : controller = controller ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode();

  @override
  State<VerbyInput> createState() => _VerbyInputState();
}

class _VerbyInputState extends State<VerbyInput> {
  late bool isObsecured = widget.obsecureText;
  late bool hasFocus = widget.autoFocus;

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(focusNodeListener);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(focusNodeListener);

    super.dispose();
  }

  String? get errorText {
    final String? Function(String text)? validator = widget.validator;
    if (validator == null) return null;

    return validator(widget.controller.text);
  }

  VerbyInputStatus get status {
    if (errorText != null) return VerbyInputStatus.inValid;

    if (widget.focusNode.hasFocus) return VerbyInputStatus.focusValid;

    if (widget.controller.text != '') return VerbyInputStatus.focusValid;

    return VerbyInputStatus.unfocus;
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = widget.focusNode;
    final textStyle = Typography.body2.regular;

    Widget child;

    child = TextField(
      controller: widget.controller,
      focusNode: focusNode,
      autofocus: widget.autoFocus,
      autocorrect: widget.autoCorrect,
      obscureText: isObsecured,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      textAlignVertical: TextAlignVertical.bottom,
      cursorHeight: textStyle.lineHeight,
      cursorWidth: 1,
      cursorColor: status.textColor.palette,
      maxLength: widget.maxLength,
      style: textStyle.setColorBySemanticColor(color: status.textColor),
      onChanged: (text) {
        setState(() {});

        final onChanged = widget.onChanged;
        if (onChanged != null) onChanged(text);
      },
      onSubmitted: (text) {
        final onSubmitted = widget.onSubmitted;
        if (onSubmitted != null) onSubmitted(text);
      },
      onTap: onTap,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textStyle.setColorBySemanticColor(
          color: VerbyInputStatus.unfocus.textColor,
        ),
        isDense: true,
        filled: false,
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        counterText: '',
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );

    child = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: child),
        buildSuffixWidget(),
      ],
    );

    child = Container(
      height: 54,
      alignment: Alignment.center,
      padding: widget.padding,
      decoration: BoxDecoration(
        border: Border.all(
          color: status.borderColor.palette,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Palette.transparent,
      ),
      child: child,
    );

    child = GestureDetector(
      onTap: onTap,
      child: child,
    );

    final String? labelText = widget.labelText;
    final String? errorText = this.errorText;
    if (labelText != null || errorText != null) {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (labelText != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                labelText,
                style: Typography.body2.medium.setColorBySemanticColor(
                  color: SemanticColor.main70,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ],
          child,
          if (errorText != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: Text(
                  errorText,
                  style: Typography.caption1.regular.setColorBySemanticColor(
                    color: SemanticColor.subCaution,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ],
      );
    }

    child = MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child,
    );

    return child;
  }

  Widget buildSuffixWidget() {
    final Widget? suffixWidget = widget.suffixWidget;
    if (suffixWidget != null) return suffixWidget;

    if (widget.obsecureText) {
      return GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          setState(() {
            isObsecured = !isObsecured;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Icon(
            isObsecured ? Icons.visibility_off : Icons.visibility,
            color: VerbyInputStatus.unfocus.textColor.palette,
            size: 24,
          ),
        ),
      );
    }

    if (hasFocus && !widget.readOnly) {
      return GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          final TextEditingController controller = widget.controller;
          controller.text = '';

          widget.focusNode.requestFocus();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Icon(
            Icons.close,
            size: 24,
            color: VerbyInputStatus.unfocus.textColor.palette,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  void focusNodeListener() {
    final bool hasFocus = widget.focusNode.hasFocus;

    setState(() {
      this.hasFocus = hasFocus;
    });

    final void Function()? onFocus = widget.onFocus;
    if (onFocus != null && hasFocus) {
      onFocus();

      return;
    }

    final void Function()? onUnFocus = widget.onUnFocus;
    if (onUnFocus != null && !hasFocus) {
      onUnFocus();

      return;
    }
  }

  void onTap() {
    widget.focusNode.requestFocus();

    final VoidCallback? onTap = widget.onTap;
    if (onTap != null) onTap();
  }
}
