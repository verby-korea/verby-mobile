import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:verby_mobile_design_tokens/verby_mobile_design_tokens.dart';

class VerbyDialogStyle extends Equatable {
  final SemanticColor backgroundColor;

  final BorderRadius borderRadius;

  final EdgeInsets insetPadding;
  final EdgeInsets contentPadding;

  const VerbyDialogStyle({
    required this.backgroundColor,
    required this.borderRadius,
    required this.insetPadding,
    required this.contentPadding,
  });

  @override
  List<Object?> get props => [
        backgroundColor,
        borderRadius,
        insetPadding,
        contentPadding,
      ];
}
