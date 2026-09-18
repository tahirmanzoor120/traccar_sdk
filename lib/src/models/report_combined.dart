import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'position.dart';

part 'report_combined.g.dart';

/// A combined route, Events, and Positions report row for one device.
@JsonSerializable()
class ReportCombined {
  final int? deviceId;

  /// Simplified route as `[longitude, latitude]` pairs.
  @JsonKey(fromJson: _routeFromJson)
  final List<List<double>>? route;

  final List<Event>? events;
  final List<Position>? positions;

  const ReportCombined({
    this.deviceId,
    this.route,
    this.events,
    this.positions,
  });

  factory ReportCombined.fromJson(Map<String, dynamic> json) =>
      _$ReportCombinedFromJson(json);

  Map<String, dynamic> toJson() => _$ReportCombinedToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportCombined && other.deviceId == deviceId;

  @override
  int get hashCode => deviceId.hashCode;

  @override
  String toString() =>
      'ReportCombined(deviceId: $deviceId, route: ${route?.length} points, '
      'events: ${events?.length}, positions: ${positions?.length})';
}

List<List<double>>? _routeFromJson(dynamic v) => v == null
    ? null
    : List<List<double>>.unmodifiable(
        (v as List<dynamic>).map<List<double>>(
          (pair) => List<double>.unmodifiable(
            (pair as List<dynamic>).map<double>((n) => (n as num).toDouble()),
          ),
        ),
      );
