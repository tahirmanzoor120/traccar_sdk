// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
  id: (json['id'] as num?)?.toInt(),
  deviceId: (json['deviceId'] as num?)?.toInt(),
  protocol: json['protocol'] as String?,
  deviceTime: json['deviceTime'] == null
      ? null
      : DateTime.parse(json['deviceTime'] as String),
  fixTime: json['fixTime'] == null
      ? null
      : DateTime.parse(json['fixTime'] as String),
  serverTime: json['serverTime'] == null
      ? null
      : DateTime.parse(json['serverTime'] as String),
  valid: json['valid'] as bool?,
  latitude: doubleFromJson(json['latitude']),
  longitude: doubleFromJson(json['longitude']),
  altitude: doubleFromJson(json['altitude']),
  speed: doubleFromJson(json['speed']),
  course: doubleFromJson(json['course']),
  address: json['address'] as String?,
  accuracy: doubleFromJson(json['accuracy']),
  network: json['network'] as Map<String, dynamic>?,
  geofenceIds: intListFromJson(json['geofenceIds']),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'id': ?instance.id,
  'deviceId': ?instance.deviceId,
  'protocol': ?instance.protocol,
  'deviceTime': ?instance.deviceTime?.toIso8601String(),
  'fixTime': ?instance.fixTime?.toIso8601String(),
  'serverTime': ?instance.serverTime?.toIso8601String(),
  'valid': ?instance.valid,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'altitude': ?instance.altitude,
  'speed': ?instance.speed,
  'course': ?instance.course,
  'address': ?instance.address,
  'accuracy': ?instance.accuracy,
  'network': ?instance.network,
  'geofenceIds': ?instance.geofenceIds,
  'attributes': ?instance.attributes,
};
