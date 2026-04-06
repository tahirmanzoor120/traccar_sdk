import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'device_accumulators.g.dart';

@JsonSerializable()
class DeviceAccumulators {
  final int? deviceId;

  @JsonKey(fromJson: doubleFromJson)
  final double? totalDistance;

  @JsonKey(fromJson: doubleFromJson)
  final double? hours;

  const DeviceAccumulators({
    this.deviceId,
    this.totalDistance,
    this.hours,
  });

  factory DeviceAccumulators.fromJson(Map<String, dynamic> json) =>
      _$DeviceAccumulatorsFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceAccumulatorsToJson(this);

  DeviceAccumulators copyWith({
    int? deviceId,
    double? totalDistance,
    double? hours,
  }) =>
      DeviceAccumulators(
        deviceId: deviceId ?? this.deviceId,
        totalDistance: totalDistance ?? this.totalDistance,
        hours: hours ?? this.hours,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceAccumulators && other.deviceId == deviceId;

  @override
  int get hashCode => deviceId.hashCode;

  @override
  String toString() =>
      'DeviceAccumulators(deviceId: $deviceId, totalDistance: $totalDistance, hours: $hours)';
}
