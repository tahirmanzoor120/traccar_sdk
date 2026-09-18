// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_stops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportStops _$ReportStopsFromJson(Map<String, dynamic> json) => ReportStops(
  deviceId: (json['deviceId'] as num?)?.toInt(),
  deviceName: json['deviceName'] as String?,
  duration: intFromJson(json['duration']),
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  address: json['address'] as String?,
  lat: doubleFromJson(json['lat']),
  lon: doubleFromJson(json['lon']),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  spentFuel: doubleFromJson(json['spentFuel']),
  engineHours: intFromJson(json['engineHours']),
);

Map<String, dynamic> _$ReportStopsToJson(ReportStops instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'deviceName': ?instance.deviceName,
      'duration': ?instance.duration,
      'startTime': ?instance.startTime?.toIso8601String(),
      'address': ?instance.address,
      'lat': ?instance.lat,
      'lon': ?instance.lon,
      'endTime': ?instance.endTime?.toIso8601String(),
      'spentFuel': ?instance.spentFuel,
      'engineHours': ?instance.engineHours,
    };
