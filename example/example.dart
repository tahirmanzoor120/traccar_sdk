// ignore_for_file: avoid_print

import 'package:traccar_sdk/traccar_sdk.dart';

/// Minimal runnable example for pub.dev scoring.
///
/// Replace the values below with your own Traccar server details.
Future<void> main() async {
  // ── 1. Setup ──────────────────────────────────────────────────────────────

  // Wire up log output before creating the client.
  TraccarLogger.onRecord.listen(
    (r) => print('[traccar][${r.level.name}] ${r.message}'),
  );

  final client = TraccarClient.basic(
    'http://localhost:8082/api',
    'admin@example.com',
    'password',
    logLevel: TraccarLogLevel.info,
  );

  // ── 2. Session ────────────────────────────────────────────────────────────

  final me = await client.session.login(
    email: 'admin@example.com',
    password: 'password',
  );
  print('Logged in as ${me.email}');

  // ── 3. Server info ────────────────────────────────────────────────────────

  final serverInfo = await client.server.getServer();
  print('Server version: ${serverInfo.version}');

  // ── 4. Devices ────────────────────────────────────────────────────────────

  final devices = await client.devices.getDevices();
  print('Devices: ${devices.length}');
  for (final d in devices) {
    print('  • ${d.name} (${d.uniqueId}) status=${d.status}');
  }

  // ── 5. WebSocket live updates (token required) ───────────────────────────

  final token = await client.session.generateToken(
    expiration: DateTime.now().add(const Duration(hours: 1)),
  );

  final tokenClient = TraccarClient.token('http://localhost:8082/api', token);
  final socket = tokenClient.createSocket();

  socket.updates.listen((update) {
    for (final pos in update.positions ?? []) {
      print(
        'position: device=${pos.deviceId} '
        'lat=${pos.latitude} lng=${pos.longitude}',
      );
    }
    for (final ev in update.events ?? []) {
      print('event: device=${ev.deviceId} type=${ev.type}');
    }
  });

  await socket.connect();

  // Give updates a few seconds then clean up.
  await Future<void>.delayed(const Duration(seconds: 5));
  socket.disconnect();

  // ── 6. Logout ─────────────────────────────────────────────────────────────

  await client.session.logout();
  client.close();
  tokenClient.close();
  print('Done.');
}
