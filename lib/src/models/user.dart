import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final bool? readonly;
  final bool? administrator;
  final String? map;

  @JsonKey(fromJson: doubleFromJson)
  final double? latitude;

  @JsonKey(fromJson: doubleFromJson)
  final double? longitude;

  @JsonKey(fromJson: intFromJson)
  final int? zoom;

  /// Only included when creating/updating a user. Never returned by GET.
  final String? password;
  final String? coordinateFormat;
  final bool? disabled;
  final DateTime? expirationTime;

  @JsonKey(fromJson: intFromJson)
  final int? deviceLimit;

  @JsonKey(fromJson: intFromJson)
  final int? userLimit;

  final bool? deviceReadonly;
  final bool? limitCommands;
  final bool? fixedEmail;
  final String? poiLayer;
  final Map<String, dynamic>? attributes;

  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.readonly,
    this.administrator,
    this.map,
    this.latitude,
    this.longitude,
    this.zoom,
    this.password,
    this.coordinateFormat,
    this.disabled,
    this.expirationTime,
    this.deviceLimit,
    this.userLimit,
    this.deviceReadonly,
    this.limitCommands,
    this.fixedEmail,
    this.poiLayer,
    this.attributes,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    bool? readonly,
    bool? administrator,
    String? map,
    double? latitude,
    double? longitude,
    int? zoom,
    String? password,
    String? coordinateFormat,
    bool? disabled,
    DateTime? expirationTime,
    int? deviceLimit,
    int? userLimit,
    bool? deviceReadonly,
    bool? limitCommands,
    bool? fixedEmail,
    String? poiLayer,
    Map<String, dynamic>? attributes,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        readonly: readonly ?? this.readonly,
        administrator: administrator ?? this.administrator,
        map: map ?? this.map,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        zoom: zoom ?? this.zoom,
        password: password ?? this.password,
        coordinateFormat: coordinateFormat ?? this.coordinateFormat,
        disabled: disabled ?? this.disabled,
        expirationTime: expirationTime ?? this.expirationTime,
        deviceLimit: deviceLimit ?? this.deviceLimit,
        userLimit: userLimit ?? this.userLimit,
        deviceReadonly: deviceReadonly ?? this.deviceReadonly,
        limitCommands: limitCommands ?? this.limitCommands,
        fixedEmail: fixedEmail ?? this.fixedEmail,
        poiLayer: poiLayer ?? this.poiLayer,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && other.id == id && other.email == email;

  @override
  int get hashCode => Object.hash(id, email);

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, administrator: $administrator)';
}
