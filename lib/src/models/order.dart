import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  final String? uniqueId;
  final String? description;
  final String? fromAddress;
  final String? toAddress;
  final Map<String, dynamic>? attributes;

  const Order({
    this.id,
    this.uniqueId,
    this.description,
    this.fromAddress,
    this.toAddress,
    this.attributes,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    int? id,
    String? uniqueId,
    String? description,
    String? fromAddress,
    String? toAddress,
    Map<String, dynamic>? attributes,
  }) => Order(
    id: id ?? this.id,
    uniqueId: uniqueId ?? this.uniqueId,
    description: description ?? this.description,
    fromAddress: fromAddress ?? this.fromAddress,
    toAddress: toAddress ?? this.toAddress,
    attributes: attributes ?? this.attributes,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Order && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Order(id: $id, uniqueId: $uniqueId, fromAddress: $fromAddress, toAddress: $toAddress)';
}
