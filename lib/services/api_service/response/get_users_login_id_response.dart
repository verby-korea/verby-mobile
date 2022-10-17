import 'package:equatable/equatable.dart';

class GetUsersLoginIdResponse extends Equatable {
  final int id;
  final String loginId;
  final String createdAt;

  const GetUsersLoginIdResponse({
    required this.id,
    required this.loginId,
    required this.createdAt,
  });

  factory GetUsersLoginIdResponse.fromJson({required Map<String, dynamic> json}) {
    return GetUsersLoginIdResponse(
      id: json['id'],
      loginId: json['login_id'],
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object> get props => [
        id,
        loginId,
        createdAt,
      ];
}
