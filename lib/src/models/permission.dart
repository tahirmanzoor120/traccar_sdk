import 'package:json_annotation/json_annotation.dart';

part 'permission.g.dart';

/// Links or unlinks two Traccar objects.
///
/// Order matters: `userId` must appear first when pairing with other IDs.
/// Example: `{ deviceId: 8, geofenceId: 16 }`
@JsonSerializable()
class Permission {
  final int? userId;
  final int? deviceId;
  final int? groupId;
  final int? geofenceId;
  final int? notificationId;
  final int? calendarId;
  final int? attributeId;
  final int? driverId;
  final int? managedUserId;
  final int? commandId;

  const Permission({
    this.userId,
    this.deviceId,
    this.groupId,
    this.geofenceId,
    this.notificationId,
    this.calendarId,
    this.attributeId,
    this.driverId,
    this.managedUserId,
    this.commandId,
  });

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Permission &&
          other.userId == userId &&
          other.deviceId == deviceId &&
          other.groupId == groupId &&
          other.geofenceId == geofenceId;

  @override
  int get hashCode =>
      Object.hash(userId, deviceId, groupId, geofenceId);

  @override
  String toString() =>
      'Permission(userId: $userId, deviceId: $deviceId, groupId: $groupId, '
      'geofenceId: $geofenceId, notificationId: $notificationId)';
}
