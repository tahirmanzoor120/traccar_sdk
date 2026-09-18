import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/event.dart';
import '../models/position.dart';
import '../models/report_combined.dart';
import '../models/report_geofences.dart';
import '../models/report_stops.dart';
import '../models/report_summary.dart';
import '../models/report_trips.dart';
import 'base_api.dart';

/// Delivery mode for the binary/mail report endpoints:
/// [xlsx] downloads a spreadsheet, [mail] queues delivery by email.
enum ReportFileType { xlsx, mail }

class ReportsApi extends BaseApi {
  ReportsApi(super.dio);

  Future<List<ReportCombined>> getCombined({
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    final response = await dio.get<List<dynamic>>(
      '/reports/combined',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => ReportCombined.fromJson(e as Map<String, dynamic>))
        .toList();
  });

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

  /// Downloads the route report as `.xlsx`, or queues it for email delivery
  /// when [format] is [ReportFileType.mail].
  ///
  /// Returns the spreadsheet bytes for [ReportFileType.xlsx], or `null` when
  /// [ReportFileType.mail] queues delivery (HTTP 204).
  Future<Uint8List?> getRouteReport({
    required ReportFileType format,
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    return _downloadOrMail('/reports/route/${format.name}', format, params);
  });

  /// Downloads the events report as `.xlsx`, or queues it for email delivery
  /// when [format] is [ReportFileType.mail].
  ///
  /// [type] filters event types (`%` matches all); [alarm] filters alarm
  /// types.
  Future<Uint8List?> getEventsReport({
    required ReportFileType format,
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
    List<String>? type,
    List<String>? alarm,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    if (type != null) params['type'] = type;
    if (alarm != null) params['alarm'] = alarm;
    return _downloadOrMail('/reports/events/${format.name}', format, params);
  });

  /// Downloads the summary report as `.xlsx`, or queues it for email
  /// delivery when [format] is [ReportFileType.mail].
  ///
  /// When [daily] is `true`, values are aggregated per day instead of over
  /// the full period.
  Future<Uint8List?> getSummaryReport({
    required ReportFileType format,
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
    bool? daily,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    if (daily != null) params['daily'] = daily;
    return _downloadOrMail('/reports/summary/${format.name}', format, params);
  });

  /// Downloads the trips report as `.xlsx`, or queues it for email delivery
  /// when [format] is [ReportFileType.mail].
  Future<Uint8List?> getTripsReport({
    required ReportFileType format,
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    return _downloadOrMail('/reports/trips/${format.name}', format, params);
  });

  /// Downloads the stops report as `.xlsx`, or queues it for email delivery
  /// when [format] is [ReportFileType.mail].
  Future<Uint8List?> getStopsReport({
    required ReportFileType format,
    required DateTime from,
    required DateTime to,
    List<int>? deviceId,
    List<int>? groupId,
  }) => guard(() async {
    final params = _baseParams(from, to);
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    return _downloadOrMail('/reports/stops/${format.name}', format, params);
  });

  /// Downloads the devices report as `.xlsx`, or queues it for email
  /// delivery when [format] is [ReportFileType.mail].
  Future<Uint8List?> getDevicesReport({required ReportFileType format}) =>
      guard(
        () async =>
            _downloadOrMail('/reports/devices/${format.name}', format, {}),
      );

  Future<Uint8List?> _downloadOrMail(
    String path,
    ReportFileType format,
    Map<String, dynamic> params,
  ) async {
    final response = await dio.get<List<int>>(
      path,
      queryParameters: params,
      options: Options(
        headers: format == ReportFileType.xlsx
            ? {
                'Accept':
                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
              }
            : null,
        responseType: ResponseType.bytes,
      ),
    );
    if (response.statusCode == 204) return null;
    return Uint8List.fromList(response.data ?? []);
  }

  Map<String, dynamic> _baseParams(DateTime from, DateTime to) => {
    'from': from.toUtc().toIso8601String(),
    'to': to.toUtc().toIso8601String(),
  };
}
