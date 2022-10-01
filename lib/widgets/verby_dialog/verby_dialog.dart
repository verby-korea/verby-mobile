import 'package:flutter/material.dart' hide Typography;
import 'package:verby_mobile/routes.dart';
import 'package:verby_mobile/widgets/widgets.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyDialog extends StatelessWidget {
  final Widget child;
  final VerbyDialogStyle? style;

  const VerbyDialog({
    super.key,
    required this.child,
    this.style,
  });

  Future show({
    BuildContext? context,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) async {
    context = context ?? Routes.navigationService.navigatorKey.currentContext;
    if (context == null) return;

    return await showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  /// `VerbyDialog.singleButton`
  /// title: VerbyDialogTitle
  /// description: VerbyDialogDescription
  /// button: VerbyButton.textButton
  factory VerbyDialog.singleButton({
    VerbyDialogStyle? dialogStyle,
    required String title,
    TextStyle? titleTypography,
    required String description,
    TextStyle? descriptionTypography,
    required String buttonTitle,
    required VoidCallback? onPressed,
    VerbyButtonStyle? buttonStyle,
  }) {
    buttonStyle ??= VerbyButton.styleFrom(styleType: VerbyButtonStyleType.primaryBlue);

    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        VerbyDialogTitle(
          title: title,
          typography: titleTypography,
        ),
        const SizedBox(height: 14),
        VerbyDialogDescription(
          description: description,
          typography: descriptionTypography,
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: VerbyButton.textButton(
            text: buttonTitle,
            onPressed: onPressed,
            style: buttonStyle,
          ),
        ),
      ],
    );

    return VerbyDialog(
      style: dialogStyle,
      child: child,
    );
  }

  /// `VerbyDialog.multipleButton`
  /// title: VerbyDialogTitle,
  /// description: VerbyDialogDescription,
  /// buttons: [VerbyButton.textButton, VerbyButton.textButton]
  factory VerbyDialog.multipleButton({
    VerbyDialogStyle? dialogStyle,
    required String title,
    TextStyle? titleTypography,
    required String description,
    TextStyle? descriptionTypography,
    required String leftButtonTitle,
    required VoidCallback? leftButtonOnPressed,
    VerbyButtonStyle? leftButtonStyle,
    required String rightButtonTitle,
    required VoidCallback? rightButtonOnPressed,
    VerbyButtonStyle? rightButtonStyle,
  }) {
    leftButtonStyle ??= VerbyButton.styleFrom(styleType: VerbyButtonStyleType.gray);
    rightButtonStyle ??= VerbyButton.styleFrom(styleType: VerbyButtonStyleType.primaryBlue);

    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        VerbyDialogTitle(
          title: title,
          typography: titleTypography,
        ),
        const SizedBox(height: 14),
        VerbyDialogDescription(
          description: description,
          typography: descriptionTypography,
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: VerbyButton.textButton(
                text: leftButtonTitle,
                onPressed: leftButtonOnPressed,
                style: leftButtonStyle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: VerbyButton.textButton(
                text: rightButtonTitle,
                onPressed: rightButtonOnPressed,
                style: rightButtonStyle,
              ),
            ),
          ],
        ),
      ],
    );

    return VerbyDialog(
      style: dialogStyle,
      child: child,
    );
  }

  static VerbyDialogStyle styleFrom({
    SemanticColor? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? insetPadding,
    EdgeInsets? contentPadding,
  }) {
    backgroundColor ??= SemanticColor.background10;

    borderRadius ??= BorderRadius.circular(8);

    insetPadding ??= const EdgeInsets.fromLTRB(20, 20, 20, 20);
    contentPadding ??= const EdgeInsets.fromLTRB(16, 28, 16, 14);

    return VerbyDialogStyle(
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      insetPadding: insetPadding,
      contentPadding: contentPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? styleFrom();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: style.borderRadius),
      insetPadding: style.insetPadding,
      child: Container(
        padding: style.contentPadding,
        decoration: BoxDecoration(
          color: style.backgroundColor.palette,
          borderRadius: style.borderRadius,
        ),
        child: child,
      ),
    );
  }
}
