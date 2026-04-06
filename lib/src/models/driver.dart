import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  final int? id;
  final String? name;
  final String? uniqueId;
  final Map<String, dynamic>? attributes;

  const Driver({
    this.id,
    this.name,
    this.uniqueId,
    this.attributes,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  Driver copyWith({
    int? id,
    String? name,
    String? uniqueId,
    Map<String, dynamic>? attributes,
  }) =>
      Driver(
        id: id ?? this.id,
        name: name ?? this.name,
        uniqueId: uniqueId ?? this.uniqueId,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Driver && other.id == id && other.uniqueId == uniqueId;

  @override
  int get hashCode => Object.hash(id, uniqueId);

  @override
  String toString() =>
      'Driver(id: $id, name: $name, uniqueId: $uniqueId)';
}
