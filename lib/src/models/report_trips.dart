import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'report_trips.g.dart';

@JsonSerializable()
class ReportTrips {
  final int? deviceId;
  final String? deviceName;

  @JsonKey(fromJson: doubleFromJson)
  final double? maxSpeed;

  @JsonKey(fromJson: doubleFromJson)
  final double? averageSpeed;

  @JsonKey(fromJson: doubleFromJson)
  final double? distance;

  @JsonKey(fromJson: doubleFromJson)
  final double? spentFuel;

  /// Trip duration in seconds.
  @JsonKey(fromJson: intFromJson)
  final int? duration;

  final DateTime? startTime;
  final String? startAddress;

  @JsonKey(fromJson: doubleFromJson)
  final double? startLat;

  @JsonKey(fromJson: doubleFromJson)
  final double? startLon;

  final DateTime? endTime;
  final String? endAddress;

  @JsonKey(fromJson: doubleFromJson)
  final double? endLat;

  @JsonKey(fromJson: doubleFromJson)
  final double? endLon;

  final String? driverUniqueId;
  final String? driverName;

  const ReportTrips({
    this.deviceId,
    this.deviceName,
    this.maxSpeed,
    this.averageSpeed,
    this.distance,
    this.spentFuel,
    this.duration,
    this.startTime,
    this.startAddress,
    this.startLat,
    this.startLon,
    this.endTime,
    this.endAddress,
    this.endLat,
    this.endLon,
    this.driverUniqueId,
    this.driverName,
  });

  factory ReportTrips.fromJson(Map<String, dynamic> json) =>
      _$ReportTripsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTripsToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportTrips &&
          other.deviceId == deviceId &&
          other.startTime == startTime;

  @override
  int get hashCode => Object.hash(deviceId, startTime);

  @override
  String toString() =>
      'ReportTrips(deviceId: $deviceId, startTime: $startTime, '
      'endTime: $endTime, distance: $distance)';
}
