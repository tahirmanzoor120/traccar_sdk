// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  uniqueId: json['uniqueId'] as String?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'uniqueId': ?instance.uniqueId,
  'attributes': ?instance.attributes,
};
