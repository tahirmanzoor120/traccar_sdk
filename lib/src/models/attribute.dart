import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  final int? id;
  final String? description;
  final String? attribute;
  final String? expression;

  /// String | Number | Boolean
  final String? type;

  const Attribute({
    this.id,
    this.description,
    this.attribute,
    this.expression,
    this.type,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);

  Attribute copyWith({
    int? id,
    String? description,
    String? attribute,
    String? expression,
    String? type,
  }) =>
      Attribute(
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
  int get hashCode =>
      Object.hash(id, description, attribute, expression, type);

  @override
  String toString() =>
      'Attribute(id: $id, description: $description, attribute: $attribute, expression: $expression, type: $type)';
}
