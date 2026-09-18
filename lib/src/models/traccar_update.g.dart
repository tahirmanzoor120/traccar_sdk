// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traccar_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraccarUpdate _$TraccarUpdateFromJson(Map<String, dynamic> json) =>
    TraccarUpdate(
      devices: (json['devices'] as List<dynamic>?)
          ?.map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TraccarUpdateToJson(TraccarUpdate instance) =>
    <String, dynamic>{
      'devices': ?instance.devices?.map((e) => e.toJson()).toList(),
      'positions': ?instance.positions?.map((e) => e.toJson()).toList(),
      'events': ?instance.events?.map((e) => e.toJson()).toList(),
    };
