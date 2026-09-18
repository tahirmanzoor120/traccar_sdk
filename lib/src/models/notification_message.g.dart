// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationMessage _$NotificationMessageFromJson(Map<String, dynamic> json) =>
    NotificationMessage(
      subject: json['subject'] as String?,
      digest: json['digest'] as String?,
      body: json['body'] as String,
      priority: json['priority'] as bool?,
    );

Map<String, dynamic> _$NotificationMessageToJson(
  NotificationMessage instance,
) => <String, dynamic>{
  'subject': ?instance.subject,
  'digest': ?instance.digest,
  'body': instance.body,
  'priority': ?instance.priority,
};
