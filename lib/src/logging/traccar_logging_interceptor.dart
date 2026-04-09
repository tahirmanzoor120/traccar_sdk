import 'package:dio/dio.dart';

import 'traccar_log_level.dart';
import 'traccar_logger.dart';

/// Dio interceptor that logs requests, responses and errors via [TraccarLogger].
///
/// Automatically attached by [TraccarClient] when [logLevel] is not [TraccarLogLevel.none].
/// The `Authorization` header value is always replaced with `[redacted]`.
class TraccarLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Stamp start time for elapsed-ms calculation in onResponse.
    options.extra['_startTime'] = DateTime.now();

    if (TraccarLogger.logLevel != TraccarLogLevel.none) {
      final sanitizedHeaders = Map<String, dynamic>.from(options.headers);
      if (sanitizedHeaders.containsKey('Authorization')) {
        sanitizedHeaders['Authorization'] = '[redacted]';
      }
      TraccarLogger.logRequest(
        options.method,
        options.uri.toString(),
        sanitizedHeaders,
        options.queryParameters,
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final startTime = response.requestOptions.extra['_startTime'] as DateTime?;
    final elapsed = startTime != null
        ? DateTime.now().difference(startTime).inMilliseconds
        : -1;

    TraccarLogger.logResponse(
      response.statusCode ?? 0,
      response.requestOptions.uri.toString(),
      elapsed,
      response.data,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    TraccarLogger.logError(
      '${err.type.name} ${response?.statusCode ?? ''} '
      '${err.requestOptions.uri} — ${err.message ?? err.error}',
    );
    handler.next(err);
  }
}
