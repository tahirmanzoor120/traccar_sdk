import 'package:json_annotation/json_annotation.dart';

part 'notification_message.g.dart';

@JsonSerializable()
class NotificationMessage {
  final String? subject;
  final String? digest;
  final String body;
  final bool? priority;

  const NotificationMessage({
    this.subject,
    this.digest,
    required this.body,
    this.priority,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMessageToJson(this);

  NotificationMessage copyWith({
    String? subject,
    String? digest,
    String? body,
    bool? priority,
  }) =>
      NotificationMessage(
        subject: subject ?? this.subject,
        digest: digest ?? this.digest,
        body: body ?? this.body,
        priority: priority ?? this.priority,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationMessage &&
          other.body == body &&
          other.subject == subject;

  @override
  int get hashCode => Object.hash(subject, body);

  @override
  String toString() =>
      'NotificationMessage(subject: $subject, body: $body)';
}
