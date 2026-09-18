// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_trips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportTrips _$ReportTripsFromJson(Map<String, dynamic> json) => ReportTrips(
  deviceId: (json['deviceId'] as num?)?.toInt(),
  deviceName: json['deviceName'] as String?,
  maxSpeed: doubleFromJson(json['maxSpeed']),
  averageSpeed: doubleFromJson(json['averageSpeed']),
  distance: doubleFromJson(json['distance']),
  spentFuel: doubleFromJson(json['spentFuel']),
  duration: intFromJson(json['duration']),
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  startAddress: json['startAddress'] as String?,
  startLat: doubleFromJson(json['startLat']),
  startLon: doubleFromJson(json['startLon']),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  endAddress: json['endAddress'] as String?,
  endLat: doubleFromJson(json['endLat']),
  endLon: doubleFromJson(json['endLon']),
  driverUniqueId: json['driverUniqueId'] as String?,
  driverName: json['driverName'] as String?,
);

Map<String, dynamic> _$ReportTripsToJson(ReportTrips instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'deviceName': ?instance.deviceName,
      'maxSpeed': ?instance.maxSpeed,
      'averageSpeed': ?instance.averageSpeed,
      'distance': ?instance.distance,
      'spentFuel': ?instance.spentFuel,
      'duration': ?instance.duration,
      'startTime': ?instance.startTime?.toIso8601String(),
      'startAddress': ?instance.startAddress,
      'startLat': ?instance.startLat,
      'startLon': ?instance.startLon,
      'endTime': ?instance.endTime?.toIso8601String(),
      'endAddress': ?instance.endAddress,
      'endLat': ?instance.endLat,
      'endLon': ?instance.endLon,
      'driverUniqueId': ?instance.driverUniqueId,
      'driverName': ?instance.driverName,
    };
