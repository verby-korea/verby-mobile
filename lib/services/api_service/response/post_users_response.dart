import 'package:equatable/equatable.dart';

class PostUsersResponse extends Equatable {
  final int id;
  final String loginId;

  const PostUsersResponse({
    required this.id,
    required this.loginId,
  });

  factory PostUsersResponse.fromJson({required Map<String, dynamic> json}) {
    return PostUsersResponse(
      id: json['id'],
      loginId: json['login_id'],
    );
  }

  @override
  List<Object> get props => [
        id,
        loginId,
      ];
}
