// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
  userId: (json['userId'] as num?)?.toInt(),
  deviceId: (json['deviceId'] as num?)?.toInt(),
  groupId: (json['groupId'] as num?)?.toInt(),
  geofenceId: (json['geofenceId'] as num?)?.toInt(),
  notificationId: (json['notificationId'] as num?)?.toInt(),
  calendarId: (json['calendarId'] as num?)?.toInt(),
  attributeId: (json['attributeId'] as num?)?.toInt(),
  driverId: (json['driverId'] as num?)?.toInt(),
  managedUserId: (json['managedUserId'] as num?)?.toInt(),
  commandId: (json['commandId'] as num?)?.toInt(),
);

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'userId': ?instance.userId,
      'deviceId': ?instance.deviceId,
      'groupId': ?instance.groupId,
      'geofenceId': ?instance.geofenceId,
      'notificationId': ?instance.notificationId,
      'calendarId': ?instance.calendarId,
      'attributeId': ?instance.attributeId,
      'driverId': ?instance.driverId,
      'managedUserId': ?instance.managedUserId,
      'commandId': ?instance.commandId,
    };
