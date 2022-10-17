import 'package:equatable/equatable.dart';

class GetUsersLoginIdRequest extends Equatable {
  final String token;

  const GetUsersLoginIdRequest({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}
