import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:verby_mobile/services/services.dart';

class Api {
  final ApiClient apiClient;

  Api({required this.apiClient});

  String get baseUrl => apiClient.baseUrl;

  Future<void> postUsersSessions({required PostUsersSessionsRequest request}) async {
    final String url = '$baseUrl/users/sessions';

    await invokeApi(
      verbs: HttpVerbs.post,
      url: url,
      body: request.toJson(),
    );

    return;
  }

  Future<PostUsersResponse> postUsers({required PostUsersRequest request}) async {
    final String url = '$baseUrl/users';

    final Map<String, dynamic>? responseBody = await invokeApi(
      verbs: HttpVerbs.post,
      url: url,
      body: request.toJson(),
    );
    if (responseBody == null) throw ApiResponseBodyMissingException(url: url);

    return PostUsersResponse.fromJson(json: responseBody);
  }

  Future<void> headUsersLoginId({
    required HeadUsersLoginIdRequest request,
  }) async {
    final String url = '$baseUrl/users?login-id=${request.loginId}';

    await invokeApi(
      verbs: HttpVerbs.head,
      url: url,
    );

    return;
  }

  Future<void> postUsersSendCertificationSms({
    required PostUsersSendCertificationSmsRequest request,
  }) async {
    final String url = '$baseUrl/users/send-certification-sms';

    await invokeApi(
      verbs: HttpVerbs.post,
      url: url,
      body: request.toJson(),
    );

    return;
  }

  Future<PostUsersVerificationTokensResponse> postUsersVerificationTokens({
    required PostUsersVerificationTokensRequest request,
  }) async {
    final String url = '$baseUrl/users/verification-tokens';

    final Map<String, dynamic>? responseBody = await invokeApi(
      verbs: HttpVerbs.post,
      url: url,
      body: request.toJson(),
    );
    if (responseBody == null) throw ApiResponseBodyMissingException(url: url);

    return PostUsersVerificationTokensResponse.fromJson(json: responseBody);
  }

  Future<GetUsersLoginIdResponse> getUsersLoginId({
    required GetUsersLoginIdRequest request,
  }) async {
    final String url = '$baseUrl/users/login-id?verification_token=${request.token}';

    final Map<String, dynamic>? responseBody = await invokeApi(
      verbs: HttpVerbs.get,
      url: url,
    );
    if (responseBody == null) throw ApiResponseBodyMissingException(url: url);

    return GetUsersLoginIdResponse.fromJson(json: responseBody);
  }
}

extension on Api {
  //TODO: implements invoke Api for multipart file

  Future<Map<String, dynamic>?> invokeApi({
    required HttpVerbs verbs,
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    final Uri uri = Uri.parse(url);

    final Response response = await verbs.call(
      uri: uri,
      headers: headers ?? apiClient.headers,
      body: body,
    );

    final String? sessionKey = response.headers[HttpHeaders.setCookieHeader];
    if (sessionKey != null) apiClient.setSession(sessionKey: sessionKey);

    final int statusCode = response.statusCode;
    final String bodyStr = utf8.decode(response.bodyBytes);

    if (statusCode == HttpStatus.ok && verbs == HttpVerbs.head && bodyStr.isEmpty) {
      return null;
    }

    if (statusCode == HttpStatus.noContent && bodyStr.isEmpty) {
      return null;
    }

    final Map<String, dynamic> bodyJson = jsonDecode(bodyStr);

    final bool isSucceed = [
      HttpStatus.ok,
      HttpStatus.created,
    ].contains(statusCode);
    if (isSucceed) return bodyJson;

    throw ApiCallErrorException(
      statusCode: statusCode,
      body: bodyJson,
    );
  }
}
