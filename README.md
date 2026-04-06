# traccar_api

A fully-typed Dart/Flutter client for the [Traccar](https://www.traccar.org/) GPS tracking server REST API (v6).

## Features

- **All 83 Traccar REST endpoints** — devices, positions, groups, geofences, users, reports, commands, notifications, calendars, drivers, maintenance, orders, attributes, permissions, statistics, server, session, share, events, health
- **Basic & Bearer-token authentication** out of the box
- **Real-time WebSocket** live updates (`TraccarUpdate` stream with auto-reconnect + exponential back-off)
- **Structured, disableable logging** via the `logging` package — zero overhead when turned off
- **Type-safe models** generated with `json_serializable` + correct `int→double` coercion
- **`TraccarException`** wraps all HTTP and network errors with `isUnauthorized`, `isNotFound`, etc. helpers

---

## Getting started

Add to `pubspec.yaml`:

```yaml
dependencies:
  traccar_api: ^0.1.0
```

Run `dart run build_runner build` to generate model serialisation code.

---

## Usage

### Basic authentication

```dart
import 'package:traccar_sdk/traccar_api.dart';

final client = TraccarClient.basic(
  'https://demo.traccar.org/api',
  'admin@example.com',
  'password',
  logLevel: TraccarLogLevel.info,
);

// Wire up log output (optional)
TraccarLogger.onRecord.listen((r) => print('[${r.level.name}] ${r.message}'));

final me = await client.session.login(
  email: 'admin@example.com',
  password: 'password',
);
final devices = await client.devices.getDevices();
```

### Token authentication

```dart
final client = TraccarClient.token(
  'https://demo.traccar.org/api',
  'eyJhbGciOi...',
);
```

### WebSocket live updates

Token authentication is required for WebSocket.

```dart
final token = await client.session.generateToken(
  expiration: DateTime.now().add(const Duration(hours: 8)),
);

final tokenClient = TraccarClient.token(baseUrl, token);
final socket = tokenClient.createSocket();

socket.updates.listen((update) {
  for (final pos in update.positions ?? []) {
    print('device ${pos.deviceId}: ${pos.latitude}, ${pos.longitude}');
  }
});

await socket.connect();
// …
socket.disconnect();
```

### Logging

```dart
// Levels: none (default), error, warning, info, verbose
TraccarLogger.logLevel = TraccarLogLevel.verbose;
TraccarLogger.onRecord.listen((r) => debugPrint(r.message));
```

Authorization header values are always **redacted** from logs.

---

## Integration tests

Start a local Traccar server via Docker:

```sh
docker compose up -d
```

Then run the integration tests:

```sh
TRACCAR_BASE_URL=http://localhost:8082/api \
TRACCAR_EMAIL=admin@example.com           \
TRACCAR_PASSWORD=admin                    \
flutter test test/integration/
```

---

## Additional information

- Traccar documentation: <https://www.traccar.org/api-reference/>
- Issue tracker: see the repository issue tracker
