import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final int? id;
  final int? deviceId;
  final String? protocol;
  final DateTime? deviceTime;
  final DateTime? fixTime;
  final DateTime? serverTime;
  final bool? valid;

  @JsonKey(fromJson: doubleFromJson)
  final double? latitude;

  @JsonKey(fromJson: doubleFromJson)
  final double? longitude;

  @JsonKey(fromJson: doubleFromJson)
  final double? altitude;

  /// Speed in knots.
  @JsonKey(fromJson: doubleFromJson)
  final double? speed;

  /// Heading in degrees (0–360).
  @JsonKey(fromJson: doubleFromJson)
  final double? course;

  final String? address;

  @JsonKey(fromJson: doubleFromJson)
  final double? accuracy;

  final Map<String, dynamic>? network;

  @JsonKey(fromJson: intListFromJson)
  final List<int>? geofenceIds;

  final Map<String, dynamic>? attributes;

  const Position({
    this.id,
    this.deviceId,
    this.protocol,
    this.deviceTime,
    this.fixTime,
    this.serverTime,
    this.valid,
    this.latitude,
    this.longitude,
    this.altitude,
    this.speed,
    this.course,
    this.address,
    this.accuracy,
    this.network,
    this.geofenceIds,
    this.attributes,
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  Position copyWith({
    int? id,
    int? deviceId,
    String? protocol,
    DateTime? deviceTime,
    DateTime? fixTime,
    DateTime? serverTime,
    bool? valid,
    double? latitude,
    double? longitude,
    double? altitude,
    double? speed,
    double? course,
    String? address,
    double? accuracy,
    Map<String, dynamic>? network,
    List<int>? geofenceIds,
    Map<String, dynamic>? attributes,
  }) =>
      Position(
        id: id ?? this.id,
        deviceId: deviceId ?? this.deviceId,
        protocol: protocol ?? this.protocol,
        deviceTime: deviceTime ?? this.deviceTime,
        fixTime: fixTime ?? this.fixTime,
        serverTime: serverTime ?? this.serverTime,
        valid: valid ?? this.valid,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        altitude: altitude ?? this.altitude,
        speed: speed ?? this.speed,
        course: course ?? this.course,
        address: address ?? this.address,
        accuracy: accuracy ?? this.accuracy,
        network: network ?? this.network,
        geofenceIds: geofenceIds ?? this.geofenceIds,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Position && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Position(id: $id, deviceId: $deviceId, lat: $latitude, lon: $longitude, '
      'speed: $speed, fixTime: $fixTime)';
}
