// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_geofences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportGeofences _$ReportGeofencesFromJson(Map<String, dynamic> json) =>
    ReportGeofences(
      deviceId: (json['deviceId'] as num?)?.toInt(),
      deviceName: json['deviceName'] as String?,
      geofenceId: (json['geofenceId'] as num?)?.toInt(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$ReportGeofencesToJson(ReportGeofences instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'deviceName': ?instance.deviceName,
      'geofenceId': ?instance.geofenceId,
      'startTime': ?instance.startTime?.toIso8601String(),
      'endTime': ?instance.endTime?.toIso8601String(),
    };
