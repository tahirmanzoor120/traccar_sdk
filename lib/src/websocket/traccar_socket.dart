import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/traccar_update.dart';
import '../traccar_client.dart';
import 'channel_connector.dart';

/// Provides a real-time stream of [TraccarUpdate] messages from
/// the Traccar WebSocket endpoint (`/api/socket`).
///
/// ## Usage
/// ```dart
/// final socket = client.createSocket();
/// socket.updates.listen((update) {
///   for (final pos in update.positions ?? []) {
///     print('${pos.deviceId}: ${pos.latitude}, ${pos.longitude}');
///   }
/// });
/// await socket.connect();
/// // …
/// socket.disconnect();
/// ```
///
/// ### Authentication
/// - [TraccarTokenAuth] — token passed as `?token=` query parameter.
/// - [TraccarCookieAuth] — JSESSIONID cookie sent as a WebSocket `Cookie` header
///   (login must have been called before connecting).
/// - [TraccarBasicAuth] — not supported directly; call `session.generateToken()`
///   first and use a [TraccarClient.token] client instead.
class TraccarSocket {
  final TraccarClient _client;

  final StreamController<TraccarUpdate> _controller =
      StreamController<TraccarUpdate>.broadcast();

  WebSocketChannel? _channel;
  bool _disposed = false;
  int _reconnectAttempt = 0;

  // Reconnect delay: 2s, 4s, 8s … capped at 60s.
  static const _maxBackoff = Duration(seconds: 60);

  TraccarSocket(this._client);

  /// Broadcast stream of parsed [TraccarUpdate] packets.
  Stream<TraccarUpdate> get updates => _controller.stream;

  /// Whether the socket is currently open.
  bool get isConnected => _channel != null && !(_controller.isClosed);

  // ── public API ──────────────────────────────────────────────────────────────

  /// Opens the WebSocket connection.
  ///
  /// Throws [StateError] when called on a disposed socket, when [TraccarBasicAuth]
  /// is used (upgrade to token or cookie auth), or when [TraccarCookieAuth] is
  /// used before a successful `login()` call.
  Future<void> connect() async {
    if (_disposed) throw StateError('TraccarSocket has been disposed.');
    _reconnectAttempt = 0;
    await _connect();
  }

  /// Closes the connection and disposes the stream. The socket cannot be
  /// reused after calling this.
  void disconnect() {
    _disposed = true;
    _channel?.sink.close();
    _channel = null;
    _controller.close();
    TraccarLogger.logWs('disconnected (user request)');
  }

  // ── private ─────────────────────────────────────────────────────────────────

  Future<void> _connect() async {
    final (uri, headers) = _buildConnection();
    TraccarLogger.logWs('connecting → $uri');

    try {
      _channel = connectTraccarWebSocket(uri, headers: headers);
      await _channel!.ready;
      _reconnectAttempt = 0;
      TraccarLogger.logWs('connected');

      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );
    } catch (e) {
      TraccarLogger.logWs('connection failed: $e');
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic raw) {
    TraccarLogger.logWsVerbose('← $raw');
    try {
      final json = jsonDecode(raw as String) as Map<String, dynamic>;
      final update = TraccarUpdate.fromJson(json);
      if (!_controller.isClosed) _controller.add(update);
    } catch (e) {
      TraccarLogger.logWs('parse error: $e');
    }
  }

  void _onError(Object error, StackTrace stack) {
    TraccarLogger.logWs('error: $error');
    if (!_controller.isClosed) _controller.addError(error, stack);
  }

  void _onDone() {
    TraccarLogger.logWs('stream closed');
    if (!_disposed) _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    _reconnectAttempt++;
    final delay = Duration(
      seconds: (_maxBackoff.inSeconds < (2 << _reconnectAttempt))
          ? _maxBackoff.inSeconds
          : (2 << _reconnectAttempt),
    );
    TraccarLogger.logWs(
      'reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempt)',
    );
    Future.delayed(delay, () {
      if (!_disposed) _connect();
    });
  }

  /// Returns the WebSocket URI and optional headers for the current auth type.
  (Uri, Map<String, dynamic>?) _buildConnection() {
    final base = Uri.parse(_client.baseUrl);
    final scheme = base.scheme == 'https' ? 'wss' : 'ws';
    final host = base.host;
    final port = base.port;

    final auth = _client.auth;
    switch (auth) {
      case TraccarBasicAuth():
        throw StateError(
          'WebSocket does not support Basic authentication. '
          'Call client.session.generateToken() and use '
          'TraccarClient.token(), or use TraccarClient.cookie() with a '
          'prior login() call.',
        );

      case TraccarTokenAuth(:final token):
        // Token is passed as a query parameter — works on all platforms.
        final uri = Uri(
          scheme: scheme,
          host: host,
          port: port != 0 ? port : null,
          path: '/api/socket',
          queryParameters: {'token': token},
        );
        return (uri, null);

      case TraccarCookieAuth(:final cookie):
        if (cookie == null) {
          throw StateError(
            'TraccarCookieAuth requires a prior login() call before '
            'connecting the WebSocket.',
          );
        }
        // Cookie is sent via a WebSocket header (supported on native/IO).
        final uri = Uri(
          scheme: scheme,
          host: host,
          port: port != 0 ? port : null,
          path: '/api/socket',
        );
        return (uri, {'Cookie': cookie});
    }
  }
}
