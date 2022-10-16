import 'package:flutter_test/flutter_test.dart';
import 'package:verby_mobile/services/services.dart';

class ErrorCodeTestCase {
  final String parseCode;
  final ErrorCode expectedErrorCode;

  const ErrorCodeTestCase({
    required this.parseCode,
    required this.expectedErrorCode,
  });

  void testSucceedParse() {
    test(
      'Test Error.parse($parseCode) method succeed',
      () {
        final ErrorCode parsedErrorCode = ErrorCode.parse(code: parseCode);

        expect(parsedErrorCode, expectedErrorCode);
      },
    );
  }
}

void main() {
  group(
    'ErrorCode Enum Unit Test',
    () {
      testSucceedParseErrorCode();

      testFailedParseErrorCode();
    },
  );
}

void testSucceedParseErrorCode() {
  const List<ErrorCodeTestCase> errorCodeTestCaseList = [
    ErrorCodeTestCase(
      parseCode: 'COMMON-001',
      expectedErrorCode: ErrorCode.common001,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-001',
      expectedErrorCode: ErrorCode.user001,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-002',
      expectedErrorCode: ErrorCode.user002,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-003',
      expectedErrorCode: ErrorCode.user003,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-004',
      expectedErrorCode: ErrorCode.user004,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-005',
      expectedErrorCode: ErrorCode.user005,
    ),
    ErrorCodeTestCase(
      parseCode: 'USER-006',
      expectedErrorCode: ErrorCode.user006,
    ),
    ErrorCodeTestCase(
      parseCode: 'AUTH-001',
      expectedErrorCode: ErrorCode.auth001,
    ),
    ErrorCodeTestCase(
      parseCode: 'AUTH-002',
      expectedErrorCode: ErrorCode.auth002,
    ),
    ErrorCodeTestCase(
      parseCode: 'AUTH-003',
      expectedErrorCode: ErrorCode.auth003,
    ),
    ErrorCodeTestCase(
      parseCode: 'ARTIST-001',
      expectedErrorCode: ErrorCode.artist001,
    ),
    ErrorCodeTestCase(
      parseCode: 'SONG-001',
      expectedErrorCode: ErrorCode.song001,
    ),
    ErrorCodeTestCase(
      parseCode: 'CONTEST-001',
      expectedErrorCode: ErrorCode.contest001,
    ),
    ErrorCodeTestCase(
      parseCode: 'SERVER-001',
      expectedErrorCode: ErrorCode.server001,
    ),
  ];

  test(
    'Test ErrorCode.values.length equal ErrorCodeTestCaseList.length',
    () {
      expect(ErrorCode.values.length, errorCodeTestCaseList.length);
    },
  );

  for (var errorCodeTestCase in errorCodeTestCaseList) {
    errorCodeTestCase.testSucceedParse();
  }

  return;
}

void testFailedParseErrorCode() {
  try {
    ErrorCode.parse(code: 'FAILED-ERROR-CODE');
  } catch (e) {
    test(
      'Test ErrorCode.parse throw ApiErrorCodeParseException on Error',
      () {
        var exception = e;

        expect(exception is ApiErrorCodeParseException, true);

        exception = exception as ApiErrorCodeParseException;

        expect(exception.code, 'FAILED-ERROR-CODE');
        expect(exception.message, 'ErrorCode.values is not contains FAILED-ERROR-CODE');
      },
    );
  }
}
