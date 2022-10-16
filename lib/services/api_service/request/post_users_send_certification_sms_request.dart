import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostUsersSendCertificationSmsRequest extends Equatable {
  final String phone;

  const PostUsersSendCertificationSmsRequest({
    required this.phone,
  });

  String toJson() {
    final Map<String, dynamic> map = {
      'phone': phone,
    };

    return jsonEncode(map);
  }

  @override
  List<Object> get props => [phone];
}
