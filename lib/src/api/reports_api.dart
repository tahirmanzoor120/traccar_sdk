import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/event.dart';
import '../models/position.dart';
import '../models/report_geofences.dart';
import '../models/report_stops.dart';
import '../models/report_summary.dart';
import '../models/report_trips.dart';
import 'base_api.dart';

class ReportsApi extends BaseApi {
  ReportsApi(super.dio);

  Future<List<Position>> getRoute({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<dynamic>>(
      '/reports/route',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Position.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<List<Event>> getEvents({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
    List<String>? type,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    if (type != null) params['type'] = type;
    final response = await dio.get<List<dynamic>>(
      '/reports/events',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Event.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<List<ReportGeofences>> getGeofenceIntervals({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
    List<int>? geofenceId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    if (geofenceId != null) params['geofenceId'] = geofenceId;
    final response = await dio.get<List<dynamic>>(
      '/reports/geofences',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => ReportGeofences.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<List<ReportSummary>> getSummary({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<dynamic>>(
      '/reports/summary',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => ReportSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<List<ReportTrips>> getTrips({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<dynamic>>(
      '/reports/trips',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => ReportTrips.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<List<ReportStops>> getStops({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<dynamic>>(
      '/reports/stops',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => ReportStops.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  /// Returns the route report as an Excel (.xlsx) spreadsheet.
  Future<Uint8List> getRouteXlsx({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<int>>(
      '/reports/route',
      queryParameters: params,
      options: Options(
        headers: {
          'Accept':
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        },
        responseType: ResponseType.bytes,
      ),
    );
    return Uint8List.fromList(response.data ?? []);
  });

  Map<String, dynamic> _baseParams(DateTime from, DateTime to) => {
    'from': from.toUtc().toIso8601String(),
    'to': to.toUtc().toIso8601String(),
  };
}
