import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final int? id;
  final String? name;
  final int? groupId;
  final Map<String, dynamic>? attributes;

  const Group({this.id, this.name, this.groupId, this.attributes});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group copyWith({
    int? id,
    String? name,
    int? groupId,
    Map<String, dynamic>? attributes,
  }) => Group(
    id: id ?? this.id,
    name: name ?? this.name,
    groupId: groupId ?? this.groupId,
    attributes: attributes ?? this.attributes,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Group && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Group(id: $id, name: $name, groupId: $groupId)';
}
