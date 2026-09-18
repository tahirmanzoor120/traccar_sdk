// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_accumulators.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceAccumulators _$DeviceAccumulatorsFromJson(Map<String, dynamic> json) =>
    DeviceAccumulators(
      deviceId: (json['deviceId'] as num?)?.toInt(),
      totalDistance: doubleFromJson(json['totalDistance']),
      hours: doubleFromJson(json['hours']),
    );

Map<String, dynamic> _$DeviceAccumulatorsToJson(DeviceAccumulators instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'totalDistance': ?instance.totalDistance,
      'hours': ?instance.hours,
    };
