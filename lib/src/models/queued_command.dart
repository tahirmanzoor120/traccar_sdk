import 'package:json_annotation/json_annotation.dart';

part 'queued_command.g.dart';

@JsonSerializable()
class QueuedCommand {
  final int? id;
  final int? deviceId;
  final String? type;
  final bool? textChannel;
  final Map<String, dynamic>? attributes;

  const QueuedCommand({
    this.id,
    this.deviceId,
    this.type,
    this.textChannel,
    this.attributes,
  });

  factory QueuedCommand.fromJson(Map<String, dynamic> json) =>
      _$QueuedCommandFromJson(json);

  Map<String, dynamic> toJson() => _$QueuedCommandToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QueuedCommand && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'QueuedCommand(id: $id, deviceId: $deviceId, type: $type)';
}
