// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calendar _$CalendarFromJson(Map<String, dynamic> json) => Calendar(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  data: json['data'] as String?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'data': ?instance.data,
  'attributes': ?instance.attributes,
};
