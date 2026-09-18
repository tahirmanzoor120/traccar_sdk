import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'base_api.dart';

/// Device camera HLS video streaming.
class StreamApi extends BaseApi {
  StreamApi(super.dio);

  /// Fetches the HLS playlist (`.m3u8`) for [deviceId]'s camera [channel].
  Future<String> getPlaylist({required int deviceId, required int channel}) =>
      guard(() async {
        final response = await dio.get<String>(
          '/stream/$deviceId/$channel/live.m3u8',
          options: Options(responseType: ResponseType.plain),
        );
        return response.data ?? '';
      });

  /// Fetches HLS video segment [index] for [deviceId]'s camera [channel].
  Future<Uint8List> getSegment({
    required int deviceId,
    required int channel,
    required int index,
  }) => guard(() async {
    final response = await dio.get<List<int>>(
      '/stream/$deviceId/$channel/$index.ts',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? []);
  });
}
