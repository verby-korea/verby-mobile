import 'package:equatable/equatable.dart';

class PostUsersVerificationTokensResponse extends Equatable {
  final int id;
  final String key;
  final String phone;
  final String expirationDate;
  final String createdAt;

  const PostUsersVerificationTokensResponse({
    required this.id,
    required this.key,
    required this.phone,
    required this.expirationDate,
    required this.createdAt,
  });

  factory PostUsersVerificationTokensResponse.fromJson({required Map<String, dynamic> json}) {
    return PostUsersVerificationTokensResponse(
      id: json['id'],
      key: json['key'],
      phone: json['phone'],
      expirationDate: json['expiration_date'],
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object> get props => [
        id,
        key,
        phone,
        expirationDate,
        createdAt,
      ];
}
