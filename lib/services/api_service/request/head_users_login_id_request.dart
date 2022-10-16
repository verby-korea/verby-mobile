import 'package:equatable/equatable.dart';

class HeadUsersLoginIdRequest extends Equatable {
  final String loginId;

  const HeadUsersLoginIdRequest({
    required this.loginId,
  });

  @override
  List<Object> get props => [loginId];
}
