# traccar_sdk

A fully-typed, production-ready **Dart & Flutter** client for the [Traccar](https://www.traccar.org/) GPS tracking server REST API v6.

[![pub.dev](https://img.shields.io/pub/v/traccar_sdk.svg)](https://pub.dev/packages/traccar_sdk)
[![Dart SDK](https://img.shields.io/badge/dart-%3E%3D3.8-0175C2?logo=dart)](https://dart.dev)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-green)](LICENSE)

---

## What is Traccar?

[Traccar](https://www.traccar.org/) is a free, open-source GPS tracking server. It supports hundreds of device protocols and exposes a full REST API for managing devices, users, positions, alerts, and more. `traccar_sdk` gives you first-class Dart access to every endpoint.

---

## Features

| Feature | Details |
|---|---|
| **Full REST coverage** | All 20 API groups, 83+ endpoints |
| **3 auth methods** | Basic (email + password), Bearer token, Cookie session |
| **Real-time WebSocket** | `TraccarSocket` stream with auto-reconnect & exponential back-off |
| **Type-safe models** | 26 models generated with `json_serializable`, correct `int→double` coercion |
| **Structured logging** | 5 log levels via the `logging` package — zero overhead when off |
| **Error helpers** | `TraccarException` with `isUnauthorized`, `isNotFound`, `isForbidden`, `isServerError`, `isNetworkError` |
| **Safe JSON parsing** | Custom transformer — non-JSON error bodies never crash the client |
| **Flutter & Dart** | Works in Flutter apps, pure Dart CLI tools, and tests |

---

## API coverage

### Resource APIs

| API class | Endpoints | What you can do |
|---|---|---|
| `SessionApi` | `session` | Login, logout, get session, generate & revoke tokens |
| `DevicesApi` | `devices` | CRUD devices, get latest positions, device accumulators |
| `UsersApi` | `users` | CRUD users, manage admin flag |
| `GroupsApi` | `groups` | CRUD device groups |
| `GeofencesApi` | `geofences` | CRUD geofences (circle, polygon, linestring) |
| `PositionsApi` | `positions` | Query historical positions by device/time |
| `NotificationsApi` | `notifications` | CRUD notifications, list supported types & notificators |
| `CalendarsApi` | `calendars` | CRUD iCal-based calendars |
| `CommandsApi` | `commands` | Saved commands, send queued commands, list types |
| `DriversApi` | `drivers` | CRUD drivers with unique identifiers |
| `AttributesApi` | `attributes` | CRUD computed attributes |
| `MaintenanceApi` | `maintenance` | CRUD maintenance schedules |
| `OrdersApi` | `orders` | CRUD dispatch orders |
| `PermissionsApi` | `permissions` | Link / unlink any two resource types |
| `ReportsApi` | `reports` | Route, events, trips, stops, summary, geofence intervals |
| `EventsApi` | `events` | Query events by device/type/time |
| `ServerApi` | `server` | Get & update server config |
| `StatisticsApi` | `statistics` | Server usage statistics |
| `ShareApi` | `share` | Shareable links for positions |
| `HealthApi` | `health` | Server health check |

### Models

| Model | Description |
|---|---|
| `User` | Platform user with admin flag & permissions |
| `Device` | GPS tracker with status, category & attributes |
| `Position` | Location fix with speed, course, altitude & rich `attributes` map |
| `Group` | Hierarchical device group |
| `Geofence` | Named area: circle, polygon, or linestring (WKT) |
| `Notification` | Alert rule with type, notificators, calendars |
| `Calendar` | iCal-encoded schedule |
| `Command` / `CommandType` | Saved or queued device commands |
| `Driver` | Driver identity linked to a device |
| `Attribute` | Computed attribute expression |
| `Maintenance` | Distance/hour-based maintenance schedule |
| `Order` | Dispatch order with from/to addresses |
| `Permission` | Generic link between any two resource types |
| `Event` | Device event (geofence enter/exit, alarm, etc.) |
| `Server` | Server configuration and feature flags |
| `Statistics` | Server-side usage counters |
| `ReportSummary` / `ReportTrips` / `ReportStops` / `ReportGeofences` | Report result rows |
| `TraccarUpdate` | WebSocket frame (positions + events + devices) |
| `NotificationType` / `NotificationMessage` / `QueuedCommand` | Supporting types |

---

## Installation

```yaml
# pubspec.yaml
dependencies:
  traccar_sdk: ^0.1.2
```

```sh
dart pub get
```

---

## Quick start

### Basic (email + password)

```dart
import 'package:traccar_sdk/traccar_sdk.dart';

final client = TraccarClient.basic(
  'https://your.traccar.server/api',
  'admin@example.com',
  'password',
  logLevel: TraccarLogLevel.info,
);

final me = await client.session.login(
  email: 'admin@example.com',
  password: 'password',
);
print('Logged in as ${me.email}');

final devices = await client.devices.getDevices();
print('${devices.length} device(s) found');

client.close();
```

### Bearer-token

```dart
final client = TraccarClient.token(
  'https://your.traccar.server/api',
  'eyJhbGciOi...',
);
```

### Cookie session (recommended for mobile apps)

Cookie auth logs in once and reuses the `JSESSIONID` cookie on every subsequent request and WebSocket connection automatically.

```dart
final client = TraccarClient.cookie(
  'https://your.traccar.server/api',
  'admin@example.com',
  'password',
);

// Login once — cookie is captured and injected from here on.
await client.session.login(
  email: 'admin@example.com',
  password: 'password',
);

final devices = await client.devices.getDevices(); // cookie sent automatically
```

---

## Real-time WebSocket updates

Token auth is required for WebSocket connections.

```dart
// Generate a long-lived token first.
await client.session.login(email: email, password: password);
final token = await client.session.generateToken(
  expiration: DateTime.now().add(const Duration(hours: 8)),
);

final tokenClient = TraccarClient.token(baseUrl, token);
final socket = tokenClient.createSocket();

socket.updates.listen((TraccarUpdate update) {
  for (final pos in update.positions ?? []) {
    print('device ${pos.deviceId}: ${pos.latitude}, ${pos.longitude}');
  }
  for (final ev in update.events ?? []) {
    print('event: ${ev.type} on device ${ev.deviceId}');
  }
  for (final dev in update.devices ?? []) {
    print('device ${dev.name} status: ${dev.status}');
  }
});

await socket.connect(); // auto-reconnects if the connection drops

// Later:
socket.disconnect();
tokenClient.close();
```

### WebSocket behaviour

| Behaviour | Detail |
|---|---|
| Auto-reconnect | Yes — reconnects on disconnect with exponential back-off |
| Back-off | 1 s → 2 s → 4 s … up to 30 s |
| Auth | Token via query param (`?token=…`) |
| Cookie auth | Supported on IO platforms; web clients should use token auth |
| Basic auth | Not supported for WebSocket (throws `StateError`) |

---

## Logging

```dart
// Set the level before creating the client.
TraccarLogger.logLevel = TraccarLogLevel.verbose;

// Attach any sink — works with print or a logging framework.
TraccarLogger.onRecord.listen((record) {
  print('[traccar][${record.level.name}] ${record.message}');
});
```

### Log levels

| Level | What is logged |
|---|---|
| `none` (default) | Nothing — zero overhead |
| `error` | HTTP errors and exceptions only |
| `warning` | Warnings and errors |
| `info` | Request method + URL + status code |
| `verbose` | Full request & response headers and bodies |

> Authorization header values are always **redacted** at every log level.

---

## Error handling

All API methods throw `TraccarException` on failure. Never throws raw `DioException`.

```dart
try {
  await client.session.login(email: email, password: wrongPassword);
} on TraccarException catch (e) {
  print(e.statusCode);  // 401
  print(e.message);     // "HTTP 401 Unauthorized"

  if (e.isUnauthorized) { /* wrong credentials */ }
  if (e.isNotFound)     { /* resource does not exist */ }
  if (e.isForbidden)    { /* insufficient permissions */ }
  if (e.isServerError)  { /* 5xx — server-side problem */ }
  if (e.isNetworkError) { /* no connection / timeout */ }
}
```

---

## Where to use

| Platform | Supported | Notes |
|---|---|---|
| Flutter (Android) | ✅ | Full support including WebSocket |
| Flutter (iOS) | ✅ | Full support including WebSocket |
| Flutter (Web) | ✅ | WebSocket uses browser `WebSocket`; cookie headers not injectable |
| Flutter (Desktop) | ✅ | macOS, Windows, Linux |
| Pure Dart (CLI/server) | ✅ | No Flutter dependency required |
| Dart backend (shelf, etc.) | ✅ | Works with any Dart server framework |

---

## Running integration tests

The integration tests run against a live Traccar server. The test suite bootstraps itself automatically:

1. Logs in with your bootstrap credentials (cookie auth)
2. Creates an ephemeral admin user
3. Generates a session token for that user
4. Runs all tests authenticated as the ephemeral user
5. Deletes all created resources and the ephemeral user on completion

```sh
# If you have Docker:
./test_local.sh

# Against an already-running server:
./test_local.sh --no-docker
```

Or run directly with your own credentials:

```sh
TRACCAR_BASE_URL=http://localhost:8082/api \
TRACCAR_EMAIL=admin@example.com           \
TRACCAR_PASSWORD=admin                    \
flutter test test/integration/
```

---

## Compatibility

| Dependency | Version |
|---|---|
| Dart SDK | `>=3.8.0 <4.0.0` |
| Flutter | `>=3.32.0` |
| `dio` | `^5.0.0` |
| `json_annotation` | `^4.9.0` |
| `web_socket_channel` | `^3.0.0` |
| `logging` | `^1.2.0` |
| Traccar server | v6 (REST API v6) |

---

## Additional resources

- [Traccar official website](https://www.traccar.org/)
- [Traccar REST API reference](https://www.traccar.org/api-reference/)
- [Traccar GitHub](https://github.com/traccar/traccar)
- [pub.dev package page](https://pub.dev/packages/traccar_sdk)

