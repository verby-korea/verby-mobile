import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostUsersSessionsRequest extends Equatable {
  final String loginId;
  final String password;

  const PostUsersSessionsRequest({
    required this.loginId,
    required this.password,
  });

  String toJson() {
    final Map<String, dynamic> map = {
      'login_id': loginId,
      'password': password,
    };

    return jsonEncode(map);
  }

  @override
  List<Object> get props => [
        loginId,
        password,
      ];
}
