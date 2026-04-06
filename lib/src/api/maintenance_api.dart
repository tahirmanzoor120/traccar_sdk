
import '../models/maintenance.dart';
import 'base_api.dart';

class MaintenanceApi extends BaseApi {
  MaintenanceApi(super.dio);

  Future<List<Maintenance>> getMaintenance({
    bool? all,
    int? userId,
    int? deviceId,
    int? groupId,
    bool? refresh,
    int? limit,
    int? offset,
    String? keyword,
  }) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (all != null) params['all'] = all;
        if (userId != null) params['userId'] = userId;
        if (deviceId != null) params['deviceId'] = deviceId;
        if (groupId != null) params['groupId'] = groupId;
        if (refresh != null) params['refresh'] = refresh;
        if (limit != null) params['limit'] = limit;
        if (offset != null) params['offset'] = offset;
        if (keyword != null) params['keyword'] = keyword;
        final response = await dio.get<List<dynamic>>(
          '/maintenance',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Maintenance.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Maintenance> createMaintenance(Maintenance maintenance) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/maintenance',
          data: maintenance.toJson(),
        );
        return Maintenance.fromJson(response.data!);
      });

  Future<Maintenance> updateMaintenance(int id, Maintenance maintenance) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/maintenance/$id',
          data: maintenance.toJson(),
        );
        return Maintenance.fromJson(response.data!);
      });

  Future<void> deleteMaintenance(int id) =>
      guard(() async => dio.delete<void>('/maintenance/$id'));
}
