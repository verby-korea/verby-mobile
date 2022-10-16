import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verby_mobile/routes.dart';

bool getIsKeyboardShowing({BuildContext? context}) {
  context ??= Routes.navigationService.navigatorKey.currentContext;
  if (context == null) return false;

  return MediaQuery.of(context).viewInsets.bottom != 0.0;
}

double getScreenBottomPadding({required BuildContext context}) {
  const double defaultBottomPadding = 20;

  if (getIsKeyboardShowing(context: context)) return 8;

  final double bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;
  return max(bottomViewPadding, defaultBottomPadding);
}
