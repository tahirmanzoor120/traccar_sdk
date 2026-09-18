import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

/// A single entry in the Traccar admin audit log.
@JsonSerializable()
class Action {
  final int? id;
  final DateTime? actionTime;
  final String? address;
  final int? userId;
  final String? userEmail;
  final String? actionType;
  final String? objectType;
  final int? objectId;
  final Map<String, dynamic>? attributes;

  const Action({
    this.id,
    this.actionTime,
    this.address,
    this.userId,
    this.userEmail,
    this.actionType,
    this.objectType,
    this.objectId,
    this.attributes,
  });

  factory Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

  Map<String, dynamic> toJson() => _$ActionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Action && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Action(id: $id, actionType: $actionType, objectType: $objectType, '
      'objectId: $objectId, actionTime: $actionTime)';
}
