extension StringExtension on String {
  bool get hasAlphabet {
    final RegExp alphabetRegex = RegExp('[a-zA-Z]+');

    return alphabetRegex.hasMatch(this);
  }

  bool get hasNum {
    final RegExp numRegex = RegExp('[0-9]+');

    return numRegex.hasMatch(this);
  }

  bool get hasSpecialCharacter {
    final RegExp specialCharacterRegex = RegExp('[~`!@#\$%^&*()\\-_=+[{\\]}\\\\|;:\'",<.>/?]+');

    return specialCharacterRegex.hasMatch(this);
  }

  bool get isValidPassword {
    return hasAlphabet && hasNum && hasSpecialCharacter && length >= 10;
  }
}
