// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
  captureTime: json['captureTime'] == null
      ? null
      : DateTime.parse(json['captureTime'] as String),
  activeUsers: (json['activeUsers'] as num?)?.toInt(),
  activeDevices: (json['activeDevices'] as num?)?.toInt(),
  requests: (json['requests'] as num?)?.toInt(),
  messagesReceived: (json['messagesReceived'] as num?)?.toInt(),
  messagesStored: (json['messagesStored'] as num?)?.toInt(),
);

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'captureTime': ?instance.captureTime?.toIso8601String(),
      'activeUsers': ?instance.activeUsers,
      'activeDevices': ?instance.activeDevices,
      'requests': ?instance.requests,
      'messagesReceived': ?instance.messagesReceived,
      'messagesStored': ?instance.messagesStored,
    };
