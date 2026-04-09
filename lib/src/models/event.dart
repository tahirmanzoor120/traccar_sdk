import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final int? id;
  final String? type;
  final DateTime? eventTime;
  final int? deviceId;
  final int? positionId;
  final int? geofenceId;
  final int? maintenanceId;
  final Map<String, dynamic>? attributes;

  const Event({
    this.id,
    this.type,
    this.eventTime,
    this.deviceId,
    this.positionId,
    this.geofenceId,
    this.maintenanceId,
    this.attributes,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({
    int? id,
    String? type,
    DateTime? eventTime,
    int? deviceId,
    int? positionId,
    int? geofenceId,
    int? maintenanceId,
    Map<String, dynamic>? attributes,
  }) => Event(
    id: id ?? this.id,
    type: type ?? this.type,
    eventTime: eventTime ?? this.eventTime,
    deviceId: deviceId ?? this.deviceId,
    positionId: positionId ?? this.positionId,
    geofenceId: geofenceId ?? this.geofenceId,
    maintenanceId: maintenanceId ?? this.maintenanceId,
    attributes: attributes ?? this.attributes,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Event && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Event(id: $id, type: $type, deviceId: $deviceId, eventTime: $eventTime)';
}
