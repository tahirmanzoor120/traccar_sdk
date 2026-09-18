// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
  id: (json['id'] as num?)?.toInt(),
  description: json['description'] as String?,
  attribute: json['attribute'] as String?,
  expression: json['expression'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
  'id': ?instance.id,
  'description': ?instance.description,
  'attribute': ?instance.attribute,
  'expression': ?instance.expression,
  'type': ?instance.type,
};
