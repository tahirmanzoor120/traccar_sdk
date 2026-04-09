import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel connectPlatformWebSocket(
  Uri uri, {
  Map<String, dynamic>? headers,
}) {
  if (headers != null && headers.isNotEmpty) {
    throw UnsupportedError(
      'WebSocket headers are not supported on web. Use token authentication.',
    );
  }

  return WebSocketChannel.connect(uri);
}
