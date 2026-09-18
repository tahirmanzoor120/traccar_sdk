// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) =>
    ReportSummary(
      deviceId: (json['deviceId'] as num?)?.toInt(),
      deviceName: json['deviceName'] as String?,
      maxSpeed: doubleFromJson(json['maxSpeed']),
      averageSpeed: doubleFromJson(json['averageSpeed']),
      distance: doubleFromJson(json['distance']),
      spentFuel: doubleFromJson(json['spentFuel']),
      engineHours: intFromJson(json['engineHours']),
    );

Map<String, dynamic> _$ReportSummaryToJson(ReportSummary instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'deviceName': ?instance.deviceName,
      'maxSpeed': ?instance.maxSpeed,
      'averageSpeed': ?instance.averageSpeed,
      'distance': ?instance.distance,
      'spentFuel': ?instance.spentFuel,
      'engineHours': ?instance.engineHours,
    };
