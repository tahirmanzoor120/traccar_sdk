import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final int? id;
  final String? name;
  final String? uniqueId;

  /// online | offline | unknown
  final String? status;
  final bool? disabled;
  final DateTime? lastUpdate;
  final int? positionId;
  final int? groupId;
  final String? phone;
  final String? model;
  final String? contact;
  final String? category;
  final Map<String, dynamic>? attributes;

  const Device({
    this.id,
    this.name,
    this.uniqueId,
    this.status,
    this.disabled,
    this.lastUpdate,
    this.positionId,
    this.groupId,
    this.phone,
    this.model,
    this.contact,
    this.category,
    this.attributes,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  Device copyWith({
    int? id,
    String? name,
    String? uniqueId,
    String? status,
    bool? disabled,
    DateTime? lastUpdate,
    int? positionId,
    int? groupId,
    String? phone,
    String? model,
    String? contact,
    String? category,
    Map<String, dynamic>? attributes,
  }) =>
      Device(
        id: id ?? this.id,
        name: name ?? this.name,
        uniqueId: uniqueId ?? this.uniqueId,
        status: status ?? this.status,
        disabled: disabled ?? this.disabled,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        positionId: positionId ?? this.positionId,
        groupId: groupId ?? this.groupId,
        phone: phone ?? this.phone,
        model: model ?? this.model,
        contact: contact ?? this.contact,
        category: category ?? this.category,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device && other.id == id && other.uniqueId == uniqueId;

  @override
  int get hashCode => Object.hash(id, uniqueId);

  @override
  String toString() =>
      'Device(id: $id, name: $name, uniqueId: $uniqueId, status: $status)';
}
