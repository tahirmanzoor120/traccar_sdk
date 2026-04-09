import 'package:json_annotation/json_annotation.dart';

part 'notification_type.g.dart';

@JsonSerializable()
class NotificationType {
  final String? type;

  const NotificationType({this.type});

  factory NotificationType.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTypeToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationType && other.type == type;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() => 'NotificationType(type: $type)';
}
