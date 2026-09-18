import 'package:dio/dio.dart';

import 'base_api.dart';

/// Unauthenticated password-recovery endpoints.
class PasswordApi extends BaseApi {
  PasswordApi(super.dio);

  /// Sends a password reset email to [email].
  ///
  /// Always responds successfully regardless of whether the email matches
  /// a user, so this cannot be used to enumerate accounts.
  Future<void> resetPassword(String email) => guard(
    () async => dio.post<void>(
      '/password/reset',
      data: {'email': email},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    ),
  );

  /// Sets a new [password] using the reset [token] emailed to the user.
  Future<void> updatePassword({
    required String token,
    required String password,
  }) => guard(
    () async => dio.post<void>(
      '/password/update',
      data: {'token': token, 'password': password},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    ),
  );
}
