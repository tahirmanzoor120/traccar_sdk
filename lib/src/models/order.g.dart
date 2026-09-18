// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: (json['id'] as num?)?.toInt(),
  uniqueId: json['uniqueId'] as String?,
  description: json['description'] as String?,
  fromAddress: json['fromAddress'] as String?,
  toAddress: json['toAddress'] as String?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': ?instance.id,
  'uniqueId': ?instance.uniqueId,
  'description': ?instance.description,
  'fromAddress': ?instance.fromAddress,
  'toAddress': ?instance.toAddress,
  'attributes': ?instance.attributes,
};
