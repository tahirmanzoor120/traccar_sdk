## 0.2.0

Updated for Traccar server API 6.15.3 (was 6.12.2). All changes are additive — no existing method signatures changed.

- Added `AuditApi` (`client.audit`) — admin-only audit log (`Action` model).
- Added `StreamApi` (`client.stream`) — device camera HLS playlist and video segments.
- Added `PasswordApi` (`client.password`) — unauthenticated password reset/update via emailed token.
- Added `get<Resource>(id)` single-fetch methods to `UsersApi`, `GeofencesApi`, `CommandsApi`, `OrdersApi`, `GroupsApi`, `CalendarsApi`, `DriversApi`, and `NotificationsApi`.
- Added `NotificationsApi.getNotificators()` and `NotificationsApi.testNotificator()`.
- Added `PermissionsApi.getPermissions()`, `linkObjectsBulk()`, and `unlinkObjectsBulk()`.
- Added `SessionApi.openSessionAs()` for admin/manager impersonation.
- Added `AttributesApi.testComputedAttribute()` to evaluate an expression without persisting it.
- Added `ReportsApi.getCombined()` (new `ReportCombined` model) and `getRouteReport()` / `getEventsReport()` / `getSummaryReport()` / `getTripsReport()` / `getStopsReport()` / `getDevicesReport()`, which download `.xlsx` bytes or queue email delivery via the new `ReportFileType` enum. `getEventsReport()` adds an `alarm` filter; `getSummaryReport()` adds a `daily` aggregation flag.

## 0.1.3

- Fixed pub.dev score regression: generated `*.g.dart` model files are now committed and published instead of being gitignored, which was causing static analysis failures, missing platform-support detection, and failed dependency lower-bound checks.
- Bumped `json_annotation` lower bound to `^4.12.0` to match the generated code.

## 0.1.2

- Improved pub package health and metadata for the next release.
- Added web-safe websocket connector handling and broader package documentation.

## 0.1.1

- Cookie-based session authentication (`TraccarCookieAuth`) with automatic `Set-Cookie` capture.
- Fixed HTTP 415 errors on GET/DELETE requests caused by a global `Content-Type` header.
- Fixed `DioException` status-code loss when Traccar returns a non-JSON body on 4xx responses.
- Integration test bootstrap redesigned: ephemeral admin creation, token generation, and automatic cleanup.

## 0.1.0

- Initial release.
- Full Traccar v6 REST API coverage (83 endpoints across 20 resources).
- Basic and Bearer-token authentication.
- Real-time WebSocket support with auto-reconnect and exponential back-off.
- Structured, disableable logging via the `logging` package.
- 26 type-safe models generated with `json_serializable`.
- Unit tests and Docker-based integration tests.
