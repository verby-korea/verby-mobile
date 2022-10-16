import 'package:either_dart/either.dart';
import 'package:verby_mobile/services/services.dart';

class AccountRepository {
  Future<Either<Failure, void>> login({
    required String loginId,
    required String password,
  }) async {
    try {
      final PostUsersSessionsRequest request = PostUsersSessionsRequest(
        loginId: loginId,
        password: password,
      );

      return Right(
        await ApiService.instance.api.postUsersSessions(request: request),
      );
    } catch (e) {
      return Left(e.toFailure());
    }
  }

  Future<Either<Failure, String>> register({
    required String loginId,
    required String password,
    required String name,
    required String phone,
    required int gender,
    required String birthday,
    required bool allowToMarketingNotification,
    required String token,
  }) async {
    try {
      final PostUsersRequest request = PostUsersRequest(
        loginId: loginId,
        password: password,
        name: name,
        phone: phone,
        gender: Gender.parse(gender: gender),
        birthday: birthday,
        allowToMarketingNotification: allowToMarketingNotification,
        token: token,
      );

      final PostUsersResponse response = await ApiService.instance.api.postUsers(request: request);

      return Right(response.loginId);
    } catch (e) {
      return Left(e.toFailure());
    }
  }

  Future<Either<Failure, void>> checkDuplicateLoginId({required String loginId}) async {
    try {
      final HeadUsersLoginIdRequest request = HeadUsersLoginIdRequest(loginId: loginId);

      return Right(
        await ApiService.instance.api.headUsersLoginId(request: request),
      );
    } catch (e) {
      return Left(e.toFailure());
    }
  }

  Future<Either<Failure, void>> issueCertificationNumberByPhone({required String phone}) async {
    try {
      final PostUsersSendCertificationSmsRequest request = PostUsersSendCertificationSmsRequest(
        phone: phone,
      );

      return Right(
        await ApiService.instance.api.postUsersSendCertificationSms(
          request: request,
        ),
      );
    } catch (e) {
      return Left(e.toFailure());
    }
  }

  Future<Either<Failure, String>> resolveCertificationNumber({
    required String phone,
    required int certificationNumber,
  }) async {
    try {
      final PostUsersVerificationTokensRequest request = PostUsersVerificationTokensRequest(
        phone: phone,
        certificationNumber: certificationNumber,
      );

      final PostUsersVerificationTokensResponse response = await ApiService.instance.api.postUsersVerificationTokens(
        request: request,
      );

      return Right(response.key);
    } catch (e) {
      return Left(e.toFailure());
    }
  }
}
