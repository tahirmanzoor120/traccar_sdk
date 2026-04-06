/// Controls the verbosity of [TraccarLogger].
///
/// Set via [TraccarLogger.logLevel]. Default is [none] — zero output.
enum TraccarLogLevel {
  /// No logging output. Default. Zero overhead.
  none,

  /// Only errors (HTTP 4xx/5xx and network failures).
  error,

  /// Errors and warnings.
  warning,

  /// Errors, warnings, and high-level request/response lines (method + URL + status).
  info,

  /// Full request/response detail including headers, query params, and body
  /// (body truncated to 2 000 chars).
  verbose,
}
