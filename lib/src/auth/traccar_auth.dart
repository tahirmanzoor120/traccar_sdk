/// Authentication credentials for Traccar API requests.
sealed class TraccarAuth {
  const TraccarAuth();
}

/// HTTP Basic authentication using email and password.
final class TraccarBasicAuth extends TraccarAuth {
  final String email;
  final String password;

  const TraccarBasicAuth({required this.email, required this.password});

  @override
  String toString() => 'TraccarBasicAuth(email: $email)';
}

/// Bearer-token authentication (API key or session token).
final class TraccarTokenAuth extends TraccarAuth {
  final String token;

  const TraccarTokenAuth({required this.token});

  @override
  String toString() => 'TraccarTokenAuth(token: [redacted])';
}

/// Cookie-based session authentication.
///
/// Call [TraccarClient.cookie] to create a client, then call
/// `client.session.login(...)` once. The `Set-Cookie` header in the login
/// response is automatically captured and injected as a `Cookie` header on
/// every subsequent request and WebSocket connection.
///
/// The [cookie] field is updated automatically by [TraccarAuthInterceptor] and
/// must not be set manually.
class TraccarCookieAuth extends TraccarAuth {
  final String email;
  final String password;

  /// The raw `name=value` cookie string captured from the last successful
  /// `Set-Cookie` response header. `null` until the first successful login.
  String? cookie;

  TraccarCookieAuth({required this.email, required this.password, this.cookie});

  @override
  String toString() => 'TraccarCookieAuth(email: $email, cookie: ${cookie != null ? "[set]" : "null"})';
}
