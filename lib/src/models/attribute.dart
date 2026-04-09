import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

/// A computed Traccar attribute definition.
///
/// Attributes let the server derive custom values from incoming position data.
@JsonSerializable()
class Attribute {
  /// Unique server-side identifier.
  final int? id;

  /// Human-readable label shown in the Traccar UI.
  final String? description;

  /// Attribute key written into the generated position payload.
  final String? attribute;

  /// Expression evaluated by the server to produce the attribute value.
  final String? expression;

  /// Data type of the calculated value: `string`, `number`, or `boolean`.
  final String? type;

  /// Creates an attribute model.
  const Attribute({
    this.id,
    this.description,
    this.attribute,
    this.expression,
    this.type,
  });

  /// Creates an [Attribute] from a Traccar JSON response.
  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  /// Converts this attribute to Traccar's JSON representation.
  Map<String, dynamic> toJson() => _$AttributeToJson(this);

  /// Returns a copy with selected fields replaced.
  Attribute copyWith({
    int? id,
    String? description,
    String? attribute,
    String? expression,
    String? type,
  }) => Attribute(
    id: id ?? this.id,
    description: description ?? this.description,
    attribute: attribute ?? this.attribute,
    expression: expression ?? this.expression,
    type: type ?? this.type,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attribute &&
          other.id == id &&
          other.description == description &&
          other.attribute == attribute &&
          other.expression == expression &&
          other.type == type;

  @override
  int get hashCode => Object.hash(id, description, attribute, expression, type);

  @override
  String toString() =>
      'Attribute(id: $id, description: $description, attribute: $attribute, expression: $expression, type: $type)';
}
