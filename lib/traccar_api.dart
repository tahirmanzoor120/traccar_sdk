/// A fully-typed Dart/Flutter client for the Traccar GPS tracking server API.
///
/// ## Quick start
///
/// ```dart
/// import 'package:traccar_sdk/traccar_api.dart';
///
/// final client = TraccarClient.basic(
///   'https://demo.traccar.org/api',
///   'admin@example.com',
///   'password',
///   logLevel: TraccarLogLevel.info,
/// );
///
/// // Wire up logging output
/// TraccarLogger.onRecord.listen((r) => print('[${r.level.name}] ${r.message}'));
///
/// // REST calls
/// final user = await client.session.login(email: 'admin@example.com', password: 'password');
/// final devices = await client.devices.getDevices();
///
/// // WebSocket live updates
/// final socket = client.createSocket();
/// socket.updates.listen((update) {
///   for (final pos in update.positions ?? []) {
///     print('device ${pos.deviceId}: ${pos.latitude}, ${pos.longitude}');
///   }
/// });
/// await socket.connect();
/// ```
library traccar_api;

// ── Client ────────────────────────────────────────────────────────────────────
export 'src/traccar_client.dart';

// ── Auth ──────────────────────────────────────────────────────────────────────
export 'src/auth/traccar_auth.dart';

// ── Exceptions ────────────────────────────────────────────────────────────────
export 'src/exceptions/traccar_exception.dart';

// ── Logging ───────────────────────────────────────────────────────────────────
export 'src/logging/traccar_log_level.dart';
export 'src/logging/traccar_logger.dart';

// ── WebSocket ─────────────────────────────────────────────────────────────────
export 'src/websocket/traccar_socket.dart';

// ── Models ────────────────────────────────────────────────────────────────────
export 'src/models/attribute.dart';
export 'src/models/calendar.dart';
export 'src/models/command.dart';
export 'src/models/command_type.dart';
export 'src/models/device.dart';
export 'src/models/device_accumulators.dart';
export 'src/models/driver.dart';
export 'src/models/event.dart';
export 'src/models/geofence.dart';
export 'src/models/group.dart';
export 'src/models/maintenance.dart';
export 'src/models/notification.dart';
export 'src/models/notification_message.dart';
export 'src/models/notification_type.dart';
export 'src/models/order.dart';
export 'src/models/permission.dart';
export 'src/models/position.dart';
export 'src/models/queued_command.dart';
export 'src/models/report_geofences.dart';
export 'src/models/report_stops.dart';
export 'src/models/report_summary.dart';
export 'src/models/report_trips.dart';
export 'src/models/server.dart';
export 'src/models/statistics.dart';
export 'src/models/traccar_update.dart';
export 'src/models/user.dart';

// ── API classes (for direct instantiation / testing) ─────────────────────────
export 'src/api/attributes_api.dart';
export 'src/api/calendars_api.dart';
export 'src/api/commands_api.dart';
export 'src/api/devices_api.dart';
export 'src/api/drivers_api.dart';
export 'src/api/events_api.dart';
export 'src/api/geofences_api.dart';
export 'src/api/groups_api.dart';
export 'src/api/health_api.dart';
export 'src/api/maintenance_api.dart';
export 'src/api/notifications_api.dart';
export 'src/api/orders_api.dart';
export 'src/api/permissions_api.dart';
export 'src/api/positions_api.dart';
export 'src/api/reports_api.dart';
export 'src/api/server_api.dart';
export 'src/api/session_api.dart';
export 'src/api/share_api.dart';
export 'src/api/statistics_api.dart';
export 'src/api/users_api.dart';
