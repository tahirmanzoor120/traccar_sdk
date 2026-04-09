import 'package:json_annotation/json_annotation.dart';

import 'device.dart';
import 'event.dart';
import 'position.dart';

part 'traccar_update.g.dart';

/// Payload received on a single WebSocket message from the Traccar server.
///
/// A message may contain any combination of updated devices, positions, and
/// events. Fields absent in the JSON will be `null`.
@JsonSerializable()
class TraccarUpdate {
  final List<Device>? devices;
  final List<Position>? positions;
  final List<Event>? events;

  const TraccarUpdate({this.devices, this.positions, this.events});

  factory TraccarUpdate.fromJson(Map<String, dynamic> json) =>
      _$TraccarUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$TraccarUpdateToJson(this);

  @override
  String toString() =>
      'TraccarUpdate(devices: ${devices?.length}, '
      'positions: ${positions?.length}, events: ${events?.length})';
}
