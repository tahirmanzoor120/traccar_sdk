// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String?,
  description: json['description'] as String?,
  always: json['always'] as bool?,
  commandId: (json['commandId'] as num?)?.toInt(),
  notificators: json['notificators'] as String?,
  calendarId: (json['calendarId'] as num?)?.toInt(),
  attributes: json['attributes'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'type': ?instance.type,
      'description': ?instance.description,
      'always': ?instance.always,
      'commandId': ?instance.commandId,
      'notificators': ?instance.notificators,
      'calendarId': ?instance.calendarId,
      'attributes': ?instance.attributes,
    };
