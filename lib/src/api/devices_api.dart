import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/device.dart';
import '../models/device_accumulators.dart';
import 'base_api.dart';

class DevicesApi extends BaseApi {
  DevicesApi(super.dio);

  Future<List<Device>> getDevices({
    bool? all,
    int? userId,
    List<int>? id,
    List<String>? uniqueId,
    bool? excludeAttributes,
    int? limit,
    int? offset,
    String? keyword,
  }) => guard(() async {
    final params = <String, dynamic>{};
    if (all != null) params['all'] = all;
    if (userId != null) params['userId'] = userId;
    if (id != null && id.isNotEmpty) params['id'] = id;
    if (uniqueId != null && uniqueId.isNotEmpty) {
      params['uniqueId'] = uniqueId;
    }
    if (excludeAttributes != null) {
      params['excludeAttributes'] = excludeAttributes;
    }
    if (limit != null) params['limit'] = limit;
    if (offset != null) params['offset'] = offset;
    if (keyword != null) params['keyword'] = keyword;
    final response = await dio.get<List<dynamic>>(
      '/devices',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Device.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<Device> createDevice(Device device) => guard(() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/devices',
      data: device.toJson(),
    );
    return Device.fromJson(response.data!);
  });

  Future<Device> updateDevice(int id, Device device) => guard(() async {
    final response = await dio.put<Map<String, dynamic>>(
      '/devices/$id',
      data: device.toJson(),
    );
    return Device.fromJson(response.data!);
  });

  Future<void> deleteDevice(int id) =>
      guard(() async => dio.delete<void>('/devices/$id'));

  Future<void> updateAccumulators(int id, DeviceAccumulators accumulators) =>
      guard(
        () async => dio.put<void>(
          '/devices/$id/accumulators',
          data: accumulators.toJson(),
        ),
      );

  /// Uploads or replaces the device image.
  ///
  /// [bytes] raw image bytes, [contentType] e.g. `image/jpeg` (default).
  /// Returns the server-assigned filename.
  Future<String> uploadImage(
    int id,
    Uint8List bytes, {
    String contentType = 'image/jpeg',
  }) => guard(() async {
    final response = await dio.post<String>(
      '/devices/$id/image',
      data: Stream.fromIterable([bytes]),
      options: Options(
        contentType: contentType,
        headers: {Headers.contentLengthHeader: bytes.length},
        responseType: ResponseType.plain,
      ),
    );
    return response.data ?? '';
  });
}
