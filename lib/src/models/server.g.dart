// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
  id: (json['id'] as num?)?.toInt(),
  registration: json['registration'] as bool?,
  readonly: json['readonly'] as bool?,
  deviceReadonly: json['deviceReadonly'] as bool?,
  limitCommands: json['limitCommands'] as bool?,
  map: json['map'] as String?,
  bingKey: json['bingKey'] as String?,
  mapUrl: json['mapUrl'] as String?,
  poiLayer: json['poiLayer'] as String?,
  announcement: json['announcement'] as String?,
  latitude: doubleFromJson(json['latitude']),
  longitude: doubleFromJson(json['longitude']),
  zoom: intFromJson(json['zoom']),
  version: json['version'] as String?,
  forceSettings: json['forceSettings'] as bool?,
  coordinateFormat: json['coordinateFormat'] as String?,
  openIdEnabled: json['openIdEnabled'] as bool?,
  openIdForce: json['openIdForce'] as bool?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'id': ?instance.id,
  'registration': ?instance.registration,
  'readonly': ?instance.readonly,
  'deviceReadonly': ?instance.deviceReadonly,
  'limitCommands': ?instance.limitCommands,
  'map': ?instance.map,
  'bingKey': ?instance.bingKey,
  'mapUrl': ?instance.mapUrl,
  'poiLayer': ?instance.poiLayer,
  'announcement': ?instance.announcement,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'zoom': ?instance.zoom,
  'version': ?instance.version,
  'forceSettings': ?instance.forceSettings,
  'coordinateFormat': ?instance.coordinateFormat,
  'openIdEnabled': ?instance.openIdEnabled,
  'openIdForce': ?instance.openIdForce,
  'attributes': ?instance.attributes,
};
