// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
  id: (json['id'] as num?)?.toInt(),
  actionTime: json['actionTime'] == null
      ? null
      : DateTime.parse(json['actionTime'] as String),
  address: json['address'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  userEmail: json['userEmail'] as String?,
  actionType: json['actionType'] as String?,
  objectType: json['objectType'] as String?,
  objectId: (json['objectId'] as num?)?.toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
  'id': ?instance.id,
  'actionTime': ?instance.actionTime?.toIso8601String(),
  'address': ?instance.address,
  'userId': ?instance.userId,
  'userEmail': ?instance.userEmail,
  'actionType': ?instance.actionType,
  'objectType': ?instance.objectType,
  'objectId': ?instance.objectId,
  'attributes': ?instance.attributes,
};
