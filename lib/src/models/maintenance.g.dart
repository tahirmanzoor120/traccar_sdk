// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Maintenance _$MaintenanceFromJson(Map<String, dynamic> json) => Maintenance(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  type: json['type'] as String?,
  start: doubleFromJson(json['start']),
  period: doubleFromJson(json['period']),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MaintenanceToJson(Maintenance instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'name': ?instance.name,
      'type': ?instance.type,
      'start': ?instance.start,
      'period': ?instance.period,
      'attributes': ?instance.attributes,
    };
