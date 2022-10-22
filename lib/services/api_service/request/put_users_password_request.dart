import 'dart:convert';

import 'package:equatable/equatable.dart';

class PutUsersPasswordRequest extends Equatable {
  final String verificationToken;
  final String password;

  const PutUsersPasswordRequest({
    required this.verificationToken,
    required this.password,
  });

  String toJson() {
    final Map<String, dynamic> map = {
      'new_password': password,
    };

    return jsonEncode(map);
  }

  @override
  List<Object> get props => [verificationToken, password];
}
