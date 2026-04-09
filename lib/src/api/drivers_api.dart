import '../models/driver.dart';
import 'base_api.dart';

class DriversApi extends BaseApi {
  DriversApi(super.dio);

  Future<List<Driver>> getDrivers({
    bool? all,
    int? userId,
    int? deviceId,
    int? groupId,
    bool? refresh,
    int? limit,
    int? offset,
    String? keyword,
  }) => guard(() async {
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
      '/drivers',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Driver.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<Driver> createDriver(Driver driver) => guard(() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/drivers',
      data: driver.toJson(),
    );
    return Driver.fromJson(response.data!);
  });

  Future<Driver> updateDriver(int id, Driver driver) => guard(() async {
    final response = await dio.put<Map<String, dynamic>>(
      '/drivers/$id',
      data: driver.toJson(),
    );
    return Driver.fromJson(response.data!);
  });

  Future<void> deleteDriver(int id) =>
      guard(() async => dio.delete<void>('/drivers/$id'));
}
