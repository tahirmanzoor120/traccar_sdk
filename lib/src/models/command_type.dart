import 'package:json_annotation/json_annotation.dart';

part 'command_type.g.dart';

@JsonSerializable()
class CommandType {
  final String? type;

  const CommandType({this.type});

  factory CommandType.fromJson(Map<String, dynamic> json) =>
      _$CommandTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CommandTypeToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CommandType && other.type == type;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() => 'CommandType(type: $type)';
}
