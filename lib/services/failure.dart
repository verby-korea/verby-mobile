import 'package:equatable/equatable.dart';
import 'package:verby_mobile/services/services.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class CommonFailure extends Failure {
  const CommonFailure({required super.message});

  @override
  List<Object> get props => [message];
}

class ApiCallFailure extends Failure {
  final int statusCode;
  final ErrorCode code;

  const ApiCallFailure({
    required this.statusCode,
    required this.code,
    required super.message,
  });

  @override
  List<Object> get props => [code, message];
}

extension FailureParserExtension on Object {
  Failure toFailure() {
    var exception = this;

    if (exception is ApiCallErrorException) {
      return ApiCallFailure(
        statusCode: exception.statusCode,
        code: exception.code,
        message: exception.message,
      );
    }

    if (exception is ApiException) {
      return CommonFailure(message: exception.message);
    }

    return CommonFailure(message: exception.toString());
  }
}
