import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostUsersVerificationTokensRequest extends Equatable {
  final String phone;
  final int certificationNumber;

  const PostUsersVerificationTokensRequest({
    required this.phone,
    required this.certificationNumber,
  });

  String toJson() {
    final Map<String, dynamic> map = {
      'phone': phone,
      'certification_number': certificationNumber,
    };

    return jsonEncode(map);
  }

  @override
  List<Object?> get props => [
        phone,
        certificationNumber,
      ];
}
