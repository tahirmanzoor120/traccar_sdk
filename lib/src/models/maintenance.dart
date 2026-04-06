import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'maintenance.g.dart';

@JsonSerializable()
class Maintenance {
  final int? id;
  final String? name;
  final String? type;

  @JsonKey(fromJson: doubleFromJson)
  final double? start;

  @JsonKey(fromJson: doubleFromJson)
  final double? period;

  final Map<String, dynamic>? attributes;

  const Maintenance({
    this.id,
    this.name,
    this.type,
    this.start,
    this.period,
    this.attributes,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceToJson(this);

  Maintenance copyWith({
    int? id,
    String? name,
    String? type,
    double? start,
    double? period,
    Map<String, dynamic>? attributes,
  }) =>
      Maintenance(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        start: start ?? this.start,
        period: period ?? this.period,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Maintenance && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Maintenance(id: $id, name: $name, type: $type)';
}
