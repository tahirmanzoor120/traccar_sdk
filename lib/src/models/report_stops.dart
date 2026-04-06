import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'report_stops.g.dart';

@JsonSerializable()
class ReportStops {
  final int? deviceId;
  final String? deviceName;

  @JsonKey(fromJson: intFromJson)
  final int? duration;

  final DateTime? startTime;
  final String? address;

  @JsonKey(fromJson: doubleFromJson)
  final double? lat;

  @JsonKey(fromJson: doubleFromJson)
  final double? lon;

  final DateTime? endTime;

  @JsonKey(fromJson: doubleFromJson)
  final double? spentFuel;

  @JsonKey(fromJson: intFromJson)
  final int? engineHours;

  const ReportStops({
    this.deviceId,
    this.deviceName,
    this.duration,
    this.startTime,
    this.address,
    this.lat,
    this.lon,
    this.endTime,
    this.spentFuel,
    this.engineHours,
  });

  factory ReportStops.fromJson(Map<String, dynamic> json) =>
      _$ReportStopsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStopsToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportStops &&
          other.deviceId == deviceId &&
          other.startTime == startTime;

  @override
  int get hashCode => Object.hash(deviceId, startTime);

  @override
  String toString() =>
      'ReportStops(deviceId: $deviceId, startTime: $startTime, '
      'duration: $duration, address: $address)';
}
