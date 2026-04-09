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
