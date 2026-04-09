import 'package:dio/dio.dart';

import 'base_api.dart';

class HealthApi extends BaseApi {
  HealthApi(super.dio);

  /// Returns `"OK"` when the server is healthy.
  Future<String> checkHealth() => guard(() async {
    final response = await dio.get<String>(
      '/health',
      options: Options(responseType: ResponseType.plain),
    );
    return response.data ?? '';
  });
}
