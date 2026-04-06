import 'package:dio/dio.dart';

import '../models/user.dart';
import 'base_api.dart';

class SessionApi extends BaseApi {
  SessionApi(super.dio);

  /// Logs in and returns the authenticated [User].
  /// Creates a server-side session (cookie-based).
  Future<User> login({
    required String email,
    required String password,
  }) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/session',
          data: {'email': email, 'password': password},
          options:
              Options(contentType: Headers.formUrlEncodedContentType),
        );
        return User.fromJson(response.data!);
      });

  /// Fetches session info for the current user (or by [token]).
  Future<User> getSession({String? token}) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (token != null) params['token'] = token;
        final response = await dio.get<Map<String, dynamic>>(
          '/session',
          queryParameters: params,
        );
        return User.fromJson(response.data!);
      });

  /// Closes the current session (logout).
  Future<void> logout() =>
      guard(() async => dio.delete<void>('/session'));

  /// Generates a session token with an optional [expiration] date.
  /// Returns the token string.
  Future<String> generateToken({DateTime? expiration}) =>
      guard(() async {
        final data = <String, dynamic>{};
        if (expiration != null) {
          data['expiration'] = expiration.toUtc().toIso8601String();
        }
        final response = await dio.post<String>(
          '/session/token',
          data: data.isNotEmpty ? data : null,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.plain,
          ),
        );
        return response.data ?? '';
      });

  /// Revokes a previously created session token.
  Future<void> revokeToken(String token) =>
      guard(() async => dio.post<void>(
            '/session/token/revoke',
            data: {'token': token},
            options:
                Options(contentType: Headers.formUrlEncodedContentType),
          ));
}
