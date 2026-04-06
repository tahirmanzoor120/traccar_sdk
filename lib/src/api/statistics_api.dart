
import '../models/statistics.dart';
import 'base_api.dart';

class StatisticsApi extends BaseApi {
  StatisticsApi(super.dio);

  Future<List<Statistics>> getStatistics({
    required DateTime from,
    required DateTime to,
  }) =>
      guard(() async {
        final response = await dio.get<List<dynamic>>(
          '/statistics',
          queryParameters: {
            'from': from.toUtc().toIso8601String(),
            'to': to.toUtc().toIso8601String(),
          },
        );
        return (response.data ?? [])
            .map((e) => Statistics.fromJson(e as Map<String, dynamic>))
            .toList();
      });
}
