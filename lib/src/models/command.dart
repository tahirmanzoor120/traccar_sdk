import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@JsonSerializable()
class Command {
  final int? id;
  final int? deviceId;
  final String? description;
  final String? type;
  final bool? textChannel;
  final Map<String, dynamic>? attributes;

  const Command({
    this.id,
    this.deviceId,
    this.description,
    this.type,
    this.textChannel,
    this.attributes,
  });

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);

  Command copyWith({
    int? id,
    int? deviceId,
    String? description,
    String? type,
    bool? textChannel,
    Map<String, dynamic>? attributes,
  }) => Command(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    description: description ?? this.description,
    type: type ?? this.type,
    textChannel: textChannel ?? this.textChannel,
    attributes: attributes ?? this.attributes,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Command &&
          other.id == id &&
          other.deviceId == deviceId &&
          other.type == type;

  @override
  int get hashCode => Object.hash(id, deviceId, type);

  @override
  String toString() =>
      'Command(id: $id, deviceId: $deviceId, type: $type, description: $description)';
}
