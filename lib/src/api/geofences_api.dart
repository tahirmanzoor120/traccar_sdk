
import '../models/geofence.dart';
import 'base_api.dart';

class GeofencesApi extends BaseApi {
  GeofencesApi(super.dio);

  Future<List<Geofence>> getGeofences({
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
          '/geofences',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Geofence.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Geofence> createGeofence(Geofence geofence) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/geofences',
          data: geofence.toJson(),
        );
        return Geofence.fromJson(response.data!);
      });

  Future<Geofence> updateGeofence(int id, Geofence geofence) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/geofences/$id',
          data: geofence.toJson(),
        );
        return Geofence.fromJson(response.data!);
      });

  Future<void> deleteGeofence(int id) =>
      guard(() async => dio.delete<void>('/geofences/$id'));
}
