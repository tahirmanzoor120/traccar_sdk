import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class Statistics {
  final DateTime? captureTime;
  final int? activeUsers;
  final int? activeDevices;
  final int? requests;
  final int? messagesReceived;
  final int? messagesStored;

  const Statistics({
    this.captureTime,
    this.activeUsers,
    this.activeDevices,
    this.requests,
    this.messagesReceived,
    this.messagesStored,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Statistics && other.captureTime == captureTime;

  @override
  int get hashCode => captureTime.hashCode;

  @override
  String toString() =>
      'Statistics(captureTime: $captureTime, activeUsers: $activeUsers, '
      'activeDevices: $activeDevices)';
}
