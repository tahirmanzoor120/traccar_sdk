// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  readonly: json['readonly'] as bool?,
  administrator: json['administrator'] as bool?,
  map: json['map'] as String?,
  latitude: doubleFromJson(json['latitude']),
  longitude: doubleFromJson(json['longitude']),
  zoom: intFromJson(json['zoom']),
  password: json['password'] as String?,
  coordinateFormat: json['coordinateFormat'] as String?,
  disabled: json['disabled'] as bool?,
  expirationTime: json['expirationTime'] == null
      ? null
      : DateTime.parse(json['expirationTime'] as String),
  deviceLimit: intFromJson(json['deviceLimit']),
  userLimit: intFromJson(json['userLimit']),
  deviceReadonly: json['deviceReadonly'] as bool?,
  limitCommands: json['limitCommands'] as bool?,
  fixedEmail: json['fixedEmail'] as bool?,
  poiLayer: json['poiLayer'] as String?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'email': ?instance.email,
  'phone': ?instance.phone,
  'readonly': ?instance.readonly,
  'administrator': ?instance.administrator,
  'map': ?instance.map,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'zoom': ?instance.zoom,
  'password': ?instance.password,
  'coordinateFormat': ?instance.coordinateFormat,
  'disabled': ?instance.disabled,
  'expirationTime': ?instance.expirationTime?.toIso8601String(),
  'deviceLimit': ?instance.deviceLimit,
  'userLimit': ?instance.userLimit,
  'deviceReadonly': ?instance.deviceReadonly,
  'limitCommands': ?instance.limitCommands,
  'fixedEmail': ?instance.fixedEmail,
  'poiLayer': ?instance.poiLayer,
  'attributes': ?instance.attributes,
};
