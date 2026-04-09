/// Thrown when a Traccar API request fails.
///
/// [statusCode] is the HTTP status code, or `null` for network-level errors.
/// [message] is a human-readable error description.
/// [data] is the raw response body, if any.
class TraccarException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  const TraccarException({this.statusCode, required this.message, this.data});

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode != null && statusCode! >= 500;
  bool get isNetworkError => statusCode == null;

  @override
  String toString() =>
      'TraccarException(statusCode: $statusCode, message: $message)';
}
