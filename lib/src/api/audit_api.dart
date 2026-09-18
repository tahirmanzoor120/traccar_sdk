import '../models/action.dart';
import 'base_api.dart';

/// Admin-only audit log access.
class AuditApi extends BaseApi {
  AuditApi(super.dio);

  /// Fetches audit log [Action]s recorded between [from] and [to].
  Future<List<Action>> getAudit({
    required DateTime from,
    required DateTime to,
  }) => guard(() async {
    final response = await dio.get<List<dynamic>>(
      '/audit',
      queryParameters: {
        'from': from.toUtc().toIso8601String(),
        'to': to.toUtc().toIso8601String(),
      },
    );
    return (response.data ?? [])
        .map((e) => Action.fromJson(e as Map<String, dynamic>))
        .toList();
  });
}
