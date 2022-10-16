import 'package:verby_mobile/services/services.dart';

abstract class ApiException implements Exception {
  final String message;

  const ApiException({
    required this.message,
  });

  @override
  String toString() => '[$runtimeType] $message';
}

class ApiServiceNotInitializedException extends ApiException {
  final String name;
  final String method;

  const ApiServiceNotInitializedException({
    required this.name,
    required this.method,
  }) : super(
          message: '$name is not initialized! Call `$method` before use $name.',
        );
}

class ApiCallErrorException extends ApiException {
  final int statusCode;

  late final ErrorCode code;

  ApiCallErrorException({
    required this.statusCode,
    required Map<String, dynamic> body,
  }) : super(message: body['message']) {
    code = ErrorCode.parse(code: body['code']);
  }
}

class ApiErrorCodeParseException extends ApiException {
  final String code;

  const ApiErrorCodeParseException({
    required this.code,
  }) : super(message: 'ErrorCode.values is not contains $code');
}

class ApiHttpVerbsException extends ApiException {
  const ApiHttpVerbsException()
      : super(
          message: 'Use HttpVerbs {post, get, put, patch, delete}',
        );
}

class ApiResponseBodyMissingException extends ApiException {
  const ApiResponseBodyMissingException({
    required String url,
  }) : super(message: '$url response body is null');
}
