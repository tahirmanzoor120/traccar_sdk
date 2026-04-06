import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/server.dart';
import 'base_api.dart';

class ServerApi extends BaseApi {
  ServerApi(super.dio);

  Future<Server> getServer() =>
      guard(() async {
        final response =
            await dio.get<Map<String, dynamic>>('/server');
        return Server.fromJson(response.data!);
      });

  Future<Server> updateServer(Server server) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/server',
          data: server.toJson(),
        );
        return Server.fromJson(response.data!);
      });

  /// Returns a reverse-geocoded address string for the given coordinates.
  Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
  }) =>
      guard(() async {
        final response = await dio.get<String>(
          '/server/geocode',
          queryParameters: {'latitude': latitude, 'longitude': longitude},
          options: Options(responseType: ResponseType.plain),
        );
        return response.data ?? '';
      });

  /// Returns all IANA timezone identifiers supported by the server.
  Future<List<String>> getTimezones() =>
      guard(() async {
        final response =
            await dio.get<List<dynamic>>('/server/timezones');
        return (response.data ?? []).cast<String>();
      });

  /// Uploads a binary file to the server at the given [path].
  Future<void> uploadFile(String path, Uint8List bytes) =>
      guard(() async => dio.post<void>(
            '/server/file/$path',
            data: Stream.fromIterable([bytes]),
            options: Options(
              contentType: 'application/octet-stream',
              headers: {Headers.contentLengthHeader: bytes.length},
            ),
          ));

  /// Triggers server garbage collection.
  Future<void> triggerGc() =>
      guard(() async => dio.get<void>('/server/gc'));

  /// Returns raw cache diagnostics text.
  Future<String> getCacheDiagnostics() =>
      guard(() async {
        final response = await dio.get<String>(
          '/server/cache',
          options: Options(responseType: ResponseType.plain),
        );
        return response.data ?? '';
      });

  /// Reboots the Traccar server process.
  Future<void> reboot() =>
      guard(() async => dio.post<void>('/server/reboot'));
}
