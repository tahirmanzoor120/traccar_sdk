import 'package:json_annotation/json_annotation.dart';

part 'report_geofences.g.dart';

@JsonSerializable()
class ReportGeofences {
  final int? deviceId;
  final String? deviceName;
  final int? geofenceId;
  final DateTime? startTime;
  final DateTime? endTime;

  const ReportGeofences({
    this.deviceId,
    this.deviceName,
    this.geofenceId,
    this.startTime,
    this.endTime,
  });

  factory ReportGeofences.fromJson(Map<String, dynamic> json) =>
      _$ReportGeofencesFromJson(json);

  Map<String, dynamic> toJson() => _$ReportGeofencesToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportGeofences &&
          other.deviceId == deviceId &&
          other.geofenceId == geofenceId &&
          other.startTime == startTime;

  @override
  int get hashCode => Object.hash(deviceId, geofenceId, startTime);

  @override
  String toString() =>
      'ReportGeofences(deviceId: $deviceId, geofenceId: $geofenceId, '
      'startTime: $startTime, endTime: $endTime)';
}
