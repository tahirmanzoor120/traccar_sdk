import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'report_summary.g.dart';

@JsonSerializable()
class ReportSummary {
  final int? deviceId;
  final String? deviceName;

  @JsonKey(fromJson: doubleFromJson)
  final double? maxSpeed;

  @JsonKey(fromJson: doubleFromJson)
  final double? averageSpeed;

  /// Distance in meters.
  @JsonKey(fromJson: doubleFromJson)
  final double? distance;

  /// Fuel spent in liters.
  @JsonKey(fromJson: doubleFromJson)
  final double? spentFuel;

  @JsonKey(fromJson: intFromJson)
  final int? engineHours;

  const ReportSummary({
    this.deviceId,
    this.deviceName,
    this.maxSpeed,
    this.averageSpeed,
    this.distance,
    this.spentFuel,
    this.engineHours,
  });

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSummaryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportSummary && other.deviceId == deviceId;

  @override
  int get hashCode => deviceId.hashCode;

  @override
  String toString() =>
      'ReportSummary(deviceId: $deviceId, deviceName: $deviceName, '
      'distance: $distance, maxSpeed: $maxSpeed)';
}
