import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:verby_mobile/services/services.dart';

class PostUsersRequest extends Equatable {
  final String loginId;
  final String password;
  final String name;
  final String phone;
  final Gender gender;
  final String birthday;
  final bool allowToMarketingNotification;
  final String token;

  const PostUsersRequest({
    required this.loginId,
    required this.password,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.allowToMarketingNotification,
    required this.token,
  });

  String toJson() {
    final Map<String, dynamic> map = {
      'login_id': loginId,
      'password': password,
      'name': name,
      'phone': phone,
      'gender': gender.value,
      'birthday': birthday,
      'allow_to_marketing_notification': allowToMarketingNotification,
      'token': token,
    };

    return jsonEncode(map);
  }

  @override
  List<Object> get props => [
        loginId,
        password,
        name,
        phone,
        gender,
        birthday,
        allowToMarketingNotification,
        token,
      ];
}
