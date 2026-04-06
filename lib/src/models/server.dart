import 'package:json_annotation/json_annotation.dart';

import '_converters.dart';

part 'server.g.dart';

@JsonSerializable()
class Server {
  final int? id;
  final bool? registration;
  final bool? readonly;
  final bool? deviceReadonly;
  final bool? limitCommands;
  final String? map;
  final String? bingKey;
  final String? mapUrl;
  final String? poiLayer;
  final String? announcement;

  @JsonKey(fromJson: doubleFromJson)
  final double? latitude;

  @JsonKey(fromJson: doubleFromJson)
  final double? longitude;

  @JsonKey(fromJson: intFromJson)
  final int? zoom;

  final String? version;
  final bool? forceSettings;
  final String? coordinateFormat;
  final bool? openIdEnabled;
  final bool? openIdForce;
  final Map<String, dynamic>? attributes;

  const Server({
    this.id,
    this.registration,
    this.readonly,
    this.deviceReadonly,
    this.limitCommands,
    this.map,
    this.bingKey,
    this.mapUrl,
    this.poiLayer,
    this.announcement,
    this.latitude,
    this.longitude,
    this.zoom,
    this.version,
    this.forceSettings,
    this.coordinateFormat,
    this.openIdEnabled,
    this.openIdForce,
    this.attributes,
  });

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);

  Map<String, dynamic> toJson() => _$ServerToJson(this);

  Server copyWith({
    int? id,
    bool? registration,
    bool? readonly,
    bool? deviceReadonly,
    bool? limitCommands,
    String? map,
    String? bingKey,
    String? mapUrl,
    String? poiLayer,
    String? announcement,
    double? latitude,
    double? longitude,
    int? zoom,
    String? version,
    bool? forceSettings,
    String? coordinateFormat,
    bool? openIdEnabled,
    bool? openIdForce,
    Map<String, dynamic>? attributes,
  }) =>
      Server(
        id: id ?? this.id,
        registration: registration ?? this.registration,
        readonly: readonly ?? this.readonly,
        deviceReadonly: deviceReadonly ?? this.deviceReadonly,
        limitCommands: limitCommands ?? this.limitCommands,
        map: map ?? this.map,
        bingKey: bingKey ?? this.bingKey,
        mapUrl: mapUrl ?? this.mapUrl,
        poiLayer: poiLayer ?? this.poiLayer,
        announcement: announcement ?? this.announcement,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        zoom: zoom ?? this.zoom,
        version: version ?? this.version,
        forceSettings: forceSettings ?? this.forceSettings,
        coordinateFormat: coordinateFormat ?? this.coordinateFormat,
        openIdEnabled: openIdEnabled ?? this.openIdEnabled,
        openIdForce: openIdForce ?? this.openIdForce,
        attributes: attributes ?? this.attributes,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Server && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Server(id: $id, version: $version)';
}
