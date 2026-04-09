import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel connectPlatformWebSocket(
  Uri uri, {
  Map<String, dynamic>? headers,
}) {
  if (headers == null || headers.isEmpty) {
    return WebSocketChannel.connect(uri);
  }

  return IOWebSocketChannel.connect(uri, headers: headers);
}
