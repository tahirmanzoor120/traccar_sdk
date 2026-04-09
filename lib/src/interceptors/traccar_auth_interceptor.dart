import 'dart:convert';

import 'package:dio/dio.dart';

import '../auth/traccar_auth.dart';

/// Injects authentication headers for every request and, for
/// [TraccarCookieAuth], captures the `Set-Cookie` header from login
/// responses so subsequent requests carry the session cookie automatically.
///
/// - [TraccarBasicAuth]  → `Authorization: Basic <base64(email:password)>`
/// - [TraccarTokenAuth]  → `Authorization: Bearer <token>`
/// - [TraccarCookieAuth] → `Cookie: <JSESSIONID=…>` (once logged in)
class TraccarAuthInterceptor extends Interceptor {
  final TraccarAuth _auth;

  TraccarAuthInterceptor(this._auth);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    switch (_auth) {
      case TraccarBasicAuth(:final email, :final password):
        final credentials = base64Encode(utf8.encode('$email:$password'));
        options.headers['Authorization'] = 'Basic $credentials';
      case TraccarTokenAuth(:final token):
        options.headers['Authorization'] = 'Bearer $token';
      case TraccarCookieAuth(:final cookie):
        if (cookie != null) {
          options.headers['Cookie'] = cookie;
        }
      // If cookie is null, no header is added — a login call must be made first.
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _captureCookie(response.headers);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _captureCookie(err.response!.headers);
    }
    handler.next(err);
  }

  // ── private ─────────────────────────────────────────────────────────────────

  /// Parses the `Set-Cookie` header and stores only the `name=value` pair
  /// (strips `Path`, `HttpOnly`, `Secure`, etc.) on [TraccarCookieAuth].
  void _captureCookie(Headers headers) {
    final cookieAuth = _auth;
    if (cookieAuth is! TraccarCookieAuth) return;

    // Dio can expose multiple Set-Cookie values; grab all of them.
    final values = headers.map['set-cookie'] ?? headers.map['Set-Cookie'];
    if (values == null || values.isEmpty) return;

    // Take the first cookie name=value from the first Set-Cookie header.
    // For Traccar this will be the JSESSIONID.
    final raw = values.first;
    final nameValue = raw.split(';').first.trim();
    if (nameValue.isNotEmpty) {
      cookieAuth.cookie = nameValue;
    }
  }
}
