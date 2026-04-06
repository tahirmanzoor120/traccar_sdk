import 'package:json_annotation/json_annotation.dart';

part 'calendar.g.dart';

@JsonSerializable()
class Calendar {
  final int? id;
  final String? name;

  /// base64-encoded iCalendar data.
  final String? data;
  final Map<String, dynamic>? attributes;

  const Calendar({
    this.id,
    this.name,
    this.data,
    this.attributes,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarToJson(this);

  Calendar copyWith({
    int? id,
    String? name,
    String? data,
    Map<String, dynamic>? attributes,
  }) =>
      Calendar(
        id: id ?? this.id,
        name: name ?? this.name,
        data: data ?? this.data,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Calendar &&
          other.id == id &&
          other.name == name &&
          other.data == data;

  @override
  int get hashCode => Object.hash(id, name, data);

  @override
  String toString() =>
      'Calendar(id: $id, name: $name)';
}
