// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_combined.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCombined _$ReportCombinedFromJson(Map<String, dynamic> json) =>
    ReportCombined(
      deviceId: (json['deviceId'] as num?)?.toInt(),
      route: _routeFromJson(json['route']),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportCombinedToJson(ReportCombined instance) =>
    <String, dynamic>{
      'deviceId': ?instance.deviceId,
      'route': ?instance.route,
      'events': ?instance.events?.map((e) => e.toJson()).toList(),
      'positions': ?instance.positions?.map((e) => e.toJson()).toList(),
    };
