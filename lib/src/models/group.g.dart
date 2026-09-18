// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  groupId: (json['groupId'] as num?)?.toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': ?instance.name,
  'groupId': ?instance.groupId,
  'attributes': ?instance.attributes,
};
