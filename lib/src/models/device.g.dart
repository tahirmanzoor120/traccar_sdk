// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  uniqueId: json['uniqueId'] as String?,
  status: json['status'] as String?,
  disabled: json['disabled'] as bool?,
  lastUpdate: json['lastUpdate'] == null
      ? null
      : DateTime.parse(json['lastUpdate'] as String),
  positionId: (json['positionId'] as num?)?.toInt(),
  groupId: (json['groupId'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  model: json['model'] as String?,
  contact: json['contact'] as String?,
  category: json['category'] as String?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'uniqueId': ?instance.uniqueId,
  'status': ?instance.status,
  'disabled': ?instance.disabled,
  'lastUpdate': ?instance.lastUpdate?.toIso8601String(),
  'positionId': ?instance.positionId,
  'groupId': ?instance.groupId,
  'phone': ?instance.phone,
  'model': ?instance.model,
  'contact': ?instance.contact,
  'category': ?instance.category,
  'attributes': ?instance.attributes,
};
