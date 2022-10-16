import 'package:flutter/services.dart';

/// Hot to use `MaskedTextInputFormatter`?
///
/// TextFormField(
///   ...
///   inputFormatters: [
///     MaskedTextInputFormatter(
///       masks: <String>[
///         <Formatter Type> Ex: 'xxx-xxxx-xxxx',
///       ],
///       separator: Ex: '-',
///     ),
///   ],
/// );
///
/// Output
/// Formatter Type: 'xxx-xxxx-xxxx', separator: '-' -> '010-1234-5678'
class MaskedTextInputFormatter extends TextInputFormatter {
  final List<String> masks;
  final String separator;

  String? _prevMask;

  MaskedTextInputFormatter({
    required this.masks,
    required this.separator,
  }) {
    if (masks.isNotEmpty) {
      masks.sort((l, r) => l.length.compareTo(r.length));

      _prevMask = masks.first;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;
    final String oldText = oldValue.text;

    if (newText.isEmpty || newText.length < oldText.length || masks.isEmpty || separator.isEmpty) {
      return newValue;
    }

    final bool pasted = (newText.length - oldText.length).abs() > 1;

    final int maskIndex = masks.indexWhere(
      (value) {
        final String maskValue = pasted ? value.replaceAll(separator, '') : value;

        return newText.length <= maskValue.length;
      },
    );

    if (maskIndex == -1) {
      return oldValue;
    }

    final String mask = masks[maskIndex];

    final bool needReset = (_prevMask != mask || newText.length - oldText.length > 1);

    _prevMask = mask;

    if (needReset) {
      final String text = newText.replaceAll(separator, '');
      String resetValue = '';
      int sep = 0;

      for (var i = 0; i < text.length; i++) {
        if (mask[i + sep] == separator) {
          resetValue += separator;
          ++sep;
        }

        resetValue += text[i];
      }

      return TextEditingValue(
        text: resetValue,
        selection: TextSelection.collapsed(
          offset: resetValue.length,
        ),
      );
    }

    if (newText.length < mask.length && mask[newText.length - 1] == separator) {
      final text = '$oldText$separator${newText.substring(newText.length - 1)}';

      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }

    return newValue;
  }
}
