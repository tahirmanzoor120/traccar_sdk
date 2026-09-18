// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => Command(
  id: (json['id'] as num?)?.toInt(),
  deviceId: (json['deviceId'] as num?)?.toInt(),
  description: json['description'] as String?,
  type: json['type'] as String?,
  textChannel: json['textChannel'] as bool?,
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
  'id': ?instance.id,
  'deviceId': ?instance.deviceId,
  'description': ?instance.description,
  'type': ?instance.type,
  'textChannel': ?instance.textChannel,
  'attributes': ?instance.attributes,
};
