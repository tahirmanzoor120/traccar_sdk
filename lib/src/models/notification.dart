import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final int? id;
  final String? type;
  final String? description;
  final bool? always;
  final int? commandId;

  /// Comma-separated list of delivery channels, e.g. `web,mail`.
  final String? notificators;
  final int? calendarId;
  final Map<String, dynamic>? attributes;

  const Notification({
    this.id,
    this.type,
    this.description,
    this.always,
    this.commandId,
    this.notificators,
    this.calendarId,
    this.attributes,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    int? id,
    String? type,
    String? description,
    bool? always,
    int? commandId,
    String? notificators,
    int? calendarId,
    Map<String, dynamic>? attributes,
  }) =>
      Notification(
        id: id ?? this.id,
        type: type ?? this.type,
        description: description ?? this.description,
        always: always ?? this.always,
        commandId: commandId ?? this.commandId,
        notificators: notificators ?? this.notificators,
        calendarId: calendarId ?? this.calendarId,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Notification && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Notification(id: $id, type: $type, notificators: $notificators)';
}
