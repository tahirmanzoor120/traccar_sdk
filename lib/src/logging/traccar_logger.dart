import 'package:logging/logging.dart';

import 'traccar_log_level.dart';

/// Central logger for the traccar_sdk package.
///
/// Disabled by default ([TraccarLogLevel.none]) — set [logLevel] to enable.
///
/// ## Wiring output
/// ```dart
/// TraccarLogger.logLevel = TraccarLogLevel.verbose;
/// TraccarLogger.onRecord.listen((record) => debugPrint('[${record.level.name}] ${record.message}'));
/// ```
abstract final class TraccarLogger {
  static final Logger _logger = Logger('traccar_sdk');
  static TraccarLogLevel _logLevel = TraccarLogLevel.none;

  /// The current log level. Defaults to [TraccarLogLevel.none].
  static TraccarLogLevel get logLevel => _logLevel;

  /// Set to a value other than [TraccarLogLevel.none] to enable logging.
  static set logLevel(TraccarLogLevel level) {
    _logLevel = level;
    hierarchicalLoggingEnabled = true;
    _logger.level = _toLevel(level);
  }

  /// Stream of [LogRecord]s emitted by this package.
  /// Listen here to pipe logs into your own output (print, debugPrint, Crashlytics, …).
  static Stream<LogRecord> get onRecord => _logger.onRecord;

  // ── internal helpers ──────────────────────────────────────────────────────

  static void logRequest(
    String method,
    String uri,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
  ) {
    if (_logLevel == TraccarLogLevel.none) return;
    if (_logLevel == TraccarLogLevel.verbose) {
      _logger.fine('→ $method $uri | params: $params | headers: $headers');
    } else {
      _logger.info('→ $method $uri');
    }
  }

  static void logResponse(
    int statusCode,
    String uri,
    int elapsedMs,
    dynamic body,
  ) {
    if (_logLevel == TraccarLogLevel.none) return;
    if (_logLevel == TraccarLogLevel.verbose) {
      final bodyStr = body?.toString() ?? '';
      final truncated = bodyStr.length > 2000
          ? '${bodyStr.substring(0, 2000)}…'
          : bodyStr;
      _logger.fine('← $statusCode $uri (${elapsedMs}ms) | $truncated');
    } else {
      _logger.info('← $statusCode $uri (${elapsedMs}ms)');
    }
  }

  static void logError(String detail) {
    if (_logLevel == TraccarLogLevel.none) return;
    _logger.severe('✗ $detail');
  }

  static void logWarning(String detail) {
    if (_logLevel == TraccarLogLevel.none) return;
    _logger.warning('⚠ $detail');
  }

  static void logWs(String message) {
    if (_logLevel == TraccarLogLevel.none) return;
    _logger.info('[WS] $message');
  }

  static void logWsVerbose(String message) {
    if (_logLevel != TraccarLogLevel.verbose) return;
    _logger.fine('[WS] $message');
  }

  static Level _toLevel(TraccarLogLevel level) => switch (level) {
    TraccarLogLevel.none => Level.OFF,
    TraccarLogLevel.error => Level.SEVERE,
    TraccarLogLevel.warning => Level.WARNING,
    TraccarLogLevel.info => Level.INFO,
    TraccarLogLevel.verbose => Level.FINE,
  };
}
