import 'package:dio/dio.dart';

import 'base_api.dart';

class ShareApi extends BaseApi {
  ShareApi(super.dio);

  /// Shares a single device location until [expiration].
  /// Returns the share token string.
  Future<String> shareDevice({
    required int deviceId,
    required DateTime expiration,
  }) => guard(() async {
    final response = await dio.post<String>(
      '/share/device',
      data: {
        'deviceId': deviceId,
        'expiration': expiration.toUtc().toIso8601String(),
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
      ),
    );
    return response.data ?? '';
  });

  /// Shares all devices in a group until [expiration].
  /// Returns the share token string.
  Future<String> shareGroup({
    required int groupId,
    required DateTime expiration,
  }) => guard(() async {
    final response = await dio.post<String>(
      '/share/group',
      data: {
        'groupId': groupId,
        'expiration': expiration.toUtc().toIso8601String(),
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
      ),
    );
    return response.data ?? '';
  });
}
