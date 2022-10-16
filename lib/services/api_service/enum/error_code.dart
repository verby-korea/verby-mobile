import 'package:verby_mobile/services/services.dart';

enum ErrorCode {
  /// **COMMON-001: 유효성 검증에 실패한 경우**
  common001(code: 'COMMON-001'),

  /// **USER-001: 계정명이 중복된 경우**
  user001(code: 'USER-001'),

  /// **USER-002: 인증에 실패한 경우**
  user002(code: 'USER-002'),

  /// **USER-003: 계정을 찾을 수 없는 경우**
  user003(code: 'USER-003'),

  /// **USER-004: 권한이 부족한 경우**
  user004(code: 'USER-004'),

  /// **USER-005: 해당 key의 인증 토큰이 존재하지 않는 경우**
  user005(code: 'USER-005'),

  /// **USER-006: 휴대폰 번호가 중복된 경우**
  user006(code: 'USER-006'),

  /// **auth001: 휴대전화 인증 번호가 유효하지 않은 경우**
  auth001(code: 'AUTH-001'),

  /// **auth002: 인증 토큰이 만료된 경우**
  auth002(code: 'AUTH-002'),

  /// **auth003: 토큰이 유효하지 않은 경우**
  auth003(code: 'AUTH-003'),

  /// **ARTIST-001: 가수를 찾을 수 없는 경우**
  artist001(code: 'ARTIST-001'),

  /// **SONG-001: 곡을 찾을 수 없는 경우**
  song001(code: 'SONG-001'),

  /// **CONTEST-001: 선정 곡 날짜가 적절치 않은 경우**
  contest001(code: 'CONTEST-001'),

  /// **SERVER-001: 서버가 요청을 처리할 수 없는 경우**
  server001(code: 'SERVER-001');

  final String code;

  const ErrorCode({
    required this.code,
  });

  factory ErrorCode.parse({required String code}) {
    final index = ErrorCode.values.indexWhere((element) => element.code == code);
    if (index == -1) throw ApiErrorCodeParseException(code: code);

    return ErrorCode.values[index];
  }
}
