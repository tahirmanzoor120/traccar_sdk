import 'dart:convert';

import 'package:dio/dio.dart';

import 'api/attributes_api.dart';
import 'api/calendars_api.dart';
import 'api/commands_api.dart';
import 'api/devices_api.dart';
import 'api/drivers_api.dart';
import 'api/events_api.dart';
import 'api/geofences_api.dart';
import 'api/groups_api.dart';
import 'api/health_api.dart';
import 'api/maintenance_api.dart';
import 'api/notifications_api.dart';
import 'api/orders_api.dart';
import 'api/permissions_api.dart';
import 'api/positions_api.dart';
import 'api/reports_api.dart';
import 'api/server_api.dart';
import 'api/session_api.dart';
import 'api/share_api.dart';
import 'api/statistics_api.dart';
import 'api/users_api.dart';
import 'auth/traccar_auth.dart';
import 'interceptors/traccar_auth_interceptor.dart';
import 'logging/traccar_log_level.dart';
import 'logging/traccar_logger.dart';
import 'logging/traccar_logging_interceptor.dart';
import 'websocket/traccar_socket.dart';

export 'auth/traccar_auth.dart';
export 'logging/traccar_log_level.dart';
export 'logging/traccar_logger.dart';
export 'websocket/traccar_socket.dart';

/// The main entry point for the Traccar REST API.
///
/// ## Basic auth
/// ```dart
/// final client = TraccarClient.basic(
///   'https://demo.traccar.org/api',
///   'admin@example.com',
///   'password',
///   logLevel: TraccarLogLevel.info,
/// );
/// ```
///
/// ## Token auth
/// ```dart
/// final client = TraccarClient.token(
///   'https://demo.traccar.org/api',
///   'eyJhbGciOi...',
/// );
/// ```
class TraccarClient {
  final String baseUrl;
  final TraccarAuth auth;
  final Dio _dio;

  // API accessors ─────────────────────────────────────────────────────────────

  late final AttributesApi attributes = AttributesApi(_dio);
  late final CalendarsApi calendars = CalendarsApi(_dio);
  late final CommandsApi commands = CommandsApi(_dio);
  late final DevicesApi devices = DevicesApi(_dio);
  late final DriversApi drivers = DriversApi(_dio);
  late final EventsApi events = EventsApi(_dio);
  late final GeofencesApi geofences = GeofencesApi(_dio);
  late final GroupsApi groups = GroupsApi(_dio);
  late final HealthApi health = HealthApi(_dio);
  late final MaintenanceApi maintenance = MaintenanceApi(_dio);
  late final NotificationsApi notifications = NotificationsApi(_dio);
  late final OrdersApi orders = OrdersApi(_dio);
  late final PermissionsApi permissions = PermissionsApi(_dio);
  late final PositionsApi positions = PositionsApi(_dio);
  late final ReportsApi reports = ReportsApi(_dio);
  late final ServerApi server = ServerApi(_dio);
  late final SessionApi session = SessionApi(_dio);
  late final ShareApi share = ShareApi(_dio);
  late final StatisticsApi statistics = StatisticsApi(_dio);
  late final UsersApi users = UsersApi(_dio);

  // ── constructors ────────────────────────────────────────────────────────────

  /// Creates a client with explicit auth.
  ///
  /// Supply a custom [dio] instance (e.g. with `DioAdapter` for testing).
  /// When [dio] is provided the client still adds its interceptors on top.
  TraccarClient({
    required this.baseUrl,
    required this.auth,
    TraccarLogLevel logLevel = TraccarLogLevel.none,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    TraccarLogger.logLevel = logLevel;
    _configureDio();
  }

  /// Shorthand for HTTP Basic authentication.
  factory TraccarClient.basic(
    String baseUrl,
    String email,
    String password, {
    TraccarLogLevel logLevel = TraccarLogLevel.none,
  }) => TraccarClient(
    baseUrl: baseUrl,
    auth: TraccarBasicAuth(email: email, password: password),
    logLevel: logLevel,
  );

  /// Shorthand for Bearer-token authentication.
  factory TraccarClient.token(
    String baseUrl,
    String token, {
    TraccarLogLevel logLevel = TraccarLogLevel.none,
  }) => TraccarClient(
    baseUrl: baseUrl,
    auth: TraccarTokenAuth(token: token),
    logLevel: logLevel,
  );

  /// Shorthand for cookie-based session authentication.
  ///
  /// After calling this, invoke `client.session.login(email: …, password: …)`
  /// once. The JSESSIONID cookie from the response is captured automatically
  /// and sent with every subsequent request and WebSocket connection.
  ///
  /// ```dart
  /// final client = TraccarClient.cookie('https://server/api', 'user@example.com', 'pass');
  /// await client.session.login(email: 'user@example.com', password: 'pass');
  /// // All further calls now carry the session cookie automatically.
  /// ```
  factory TraccarClient.cookie(
    String baseUrl,
    String email,
    String password, {
    TraccarLogLevel logLevel = TraccarLogLevel.none,
  }) => TraccarClient(
    baseUrl: baseUrl,
    auth: TraccarCookieAuth(email: email, password: password),
    logLevel: logLevel,
  );

  // ── WebSocket ───────────────────────────────────────────────────────────────

  /// Creates a [TraccarSocket] bound to this client's server and auth.
  TraccarSocket createSocket() => TraccarSocket(this);

  // ── lifecycle ───────────────────────────────────────────────────────────────

  /// Closes all underlying connections. Call this when done with the client.
  void close() => _dio.close(force: true);

  // ── private ─────────────────────────────────────────────────────────────────

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        // Only set Accept globally; Content-Type is set per-request so that
        // it is not sent on requests that carry no body (GET, DELETE, etc.).
        'Accept': 'application/json',
      },
    );
    _dio.transformer = SyncTransformer(jsonDecodeCallback: _safeJsonDecode);
    _dio.interceptors.addAll([
      TraccarAuthInterceptor(auth),
      TraccarLoggingInterceptor(),
    ]);
  }
}

/// JSON decoder that returns the raw [text] string on [FormatException].
///
/// Prevents Dio from throwing [DioExceptionType.unknown] when a server
/// responds with a non-JSON body but declares `Content-Type: application/json`
/// (e.g. Traccar returns a Java stack trace on 401).
dynamic _safeJsonDecode(String text) {
  try {
    return jsonDecode(text);
  } on FormatException {
    return text;
  }
}
