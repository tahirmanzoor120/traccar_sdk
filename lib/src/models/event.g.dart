// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String?,
  eventTime: json['eventTime'] == null
      ? null
      : DateTime.parse(json['eventTime'] as String),
  deviceId: (json['deviceId'] as num?)?.toInt(),
  positionId: (json['positionId'] as num?)?.toInt(),
  geofenceId: (json['geofenceId'] as num?)?.toInt(),
  maintenanceId: (json['maintenanceId'] as num?)?.toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'id': ?instance.id,
  'type': ?instance.type,
  'eventTime': ?instance.eventTime?.toIso8601String(),
  'deviceId': ?instance.deviceId,
  'positionId': ?instance.positionId,
  'geofenceId': ?instance.geofenceId,
  'maintenanceId': ?instance.maintenanceId,
  'attributes': ?instance.attributes,
};
