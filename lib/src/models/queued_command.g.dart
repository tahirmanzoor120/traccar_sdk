// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queued_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueuedCommand _$QueuedCommandFromJson(Map<String, dynamic> json) =>
    QueuedCommand(
      id: (json['id'] as num?)?.toInt(),
      deviceId: (json['deviceId'] as num?)?.toInt(),
      type: json['type'] as String?,
      textChannel: json['textChannel'] as bool?,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$QueuedCommandToJson(QueuedCommand instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'deviceId': ?instance.deviceId,
      'type': ?instance.type,
      'textChannel': ?instance.textChannel,
      'attributes': ?instance.attributes,
    };
