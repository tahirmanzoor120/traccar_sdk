import 'package:dio/dio.dart';

import '../exceptions/traccar_exception.dart';

/// Base class for all Traccar API service classes.
///
/// Provides [guard] which runs a Dio call and converts [DioException]s
/// to [TraccarException]s.
abstract class BaseApi {
  final Dio dio;

  const BaseApi(this.dio);

  /// Runs [request] and converts any [DioException] to a [TraccarException].
  Future<T> guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _convert(e);
    }
  }

  TraccarException _convert(DioException e) {
    final response = e.response;
    final message = _extractMessage(response?.data) ??
        e.message ??
        'Request failed (${e.type.name})';
    return TraccarException(
      statusCode: response?.statusCode,
      message: message,
      data: response?.data,
    );
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String?;
    }
    if (data is String && data.isNotEmpty) {
      // Use only the first non-empty line to avoid including stack traces.
      final firstLine = data.split('\n').map((l) => l.trim()).firstWhere(
        (l) => l.isNotEmpty,
        orElse: () => '',
      );
      return firstLine.isEmpty ? null : firstLine;
    }
    return null;
  }
}
