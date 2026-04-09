import 'package:json_annotation/json_annotation.dart';

part 'geofence.g.dart';

@JsonSerializable()
class Geofence {
  final int? id;
  final String? name;
  final String? description;

  /// WKT-encoded area definition (e.g. `CIRCLE (lat lon radius)`).
  final String? area;
  final int? calendarId;
  final Map<String, dynamic>? attributes;

  const Geofence({
    this.id,
    this.name,
    this.description,
    this.area,
    this.calendarId,
    this.attributes,
  });

  factory Geofence.fromJson(Map<String, dynamic> json) =>
      _$GeofenceFromJson(json);

  Map<String, dynamic> toJson() => _$GeofenceToJson(this);

  Geofence copyWith({
    int? id,
    String? name,
    String? description,
    String? area,
    int? calendarId,
    Map<String, dynamic>? attributes,
  }) => Geofence(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    area: area ?? this.area,
    calendarId: calendarId ?? this.calendarId,
    attributes: attributes ?? this.attributes,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Geofence && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Geofence(id: $id, name: $name, area: $area)';
}
