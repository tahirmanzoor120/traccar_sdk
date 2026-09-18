// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geofence _$GeofenceFromJson(Map<String, dynamic> json) => Geofence(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  area: json['area'] as String?,
  calendarId: (json['calendarId'] as num?)?.toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$GeofenceToJson(Geofence instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'description': ?instance.description,
  'area': ?instance.area,
  'calendarId': ?instance.calendarId,
  'attributes': ?instance.attributes,
};
