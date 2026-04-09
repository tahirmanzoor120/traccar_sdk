import 'package:web_socket_channel/web_socket_channel.dart';

import 'channel_connector_web.dart'
    if (dart.library.io) 'channel_connector_io.dart';

WebSocketChannel connectTraccarWebSocket(
  Uri uri, {
  Map<String, dynamic>? headers,
}) => connectPlatformWebSocket(uri, headers: headers);
