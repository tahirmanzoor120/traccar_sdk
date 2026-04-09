import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/position.dart';
import 'base_api.dart';

class PositionsApi extends BaseApi {
  PositionsApi(super.dio);

  /// Returns last known positions for all devices or a range for one device.
  ///
  /// [from] and [to] are required when [deviceId] is provided.
  Future<List<Position>> getPositions({
    int? deviceId,
    DateTime? from,
    DateTime? to,
    List<int>? id,
  }) => guard(() async {
    final params = <String, dynamic>{};
    if (deviceId != null) params['deviceId'] = deviceId;
    if (from != null) params['from'] = from.toUtc().toIso8601String();
    if (to != null) params['to'] = to.toUtc().toIso8601String();
    if (id != null && id.isNotEmpty) params['id'] = id;
    final response = await dio.get<List<dynamic>>(
      '/positions',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Position.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  /// Deletes all positions for [deviceId] in the given time range.
  Future<void> deletePositions({
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) => guard(
    () async => dio.delete<void>(
      '/positions',
      queryParameters: {
        'deviceId': deviceId,
        'from': from.toUtc().toIso8601String(),
        'to': to.toUtc().toIso8601String(),
      },
    ),
  );

  /// Deletes a single position by id.
  Future<void> deletePosition(int id) =>
      guard(() async => dio.delete<void>('/positions/$id'));

  /// Exports positions as KML bytes.
  Future<Uint8List> exportKml({
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) => guard(() async {
    final response = await dio.get<List<int>>(
      '/positions/kml',
      queryParameters: {
        'deviceId': deviceId,
        'from': from.toUtc().toIso8601String(),
        'to': to.toUtc().toIso8601String(),
      },
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? []);
  });

  /// Exports positions as CSV bytes.
  Future<Uint8List> exportCsv({
    required int deviceId,
    required DateTime from,
    required DateTime to,
    int? geofenceId,
  }) => guard(() async {
    final params = <String, dynamic>{
      'deviceId': deviceId,
      'from': from.toUtc().toIso8601String(),
      'to': to.toUtc().toIso8601String(),
    };
    if (geofenceId != null) params['geofenceId'] = geofenceId;
    final response = await dio.get<List<int>>(
      '/positions/csv',
      queryParameters: params,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? []);
  });

  /// Exports positions as GPX bytes.
  Future<Uint8List> exportGpx({
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) => guard(() async {
    final response = await dio.get<List<int>>(
      '/positions/gpx',
      queryParameters: {
        'deviceId': deviceId,
        'from': from.toUtc().toIso8601String(),
        'to': to.toUtc().toIso8601String(),
      },
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? []);
  });
}
