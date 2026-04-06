import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_api.dart';

void main() {
  group('TraccarException', () {
    test('constructor sets fields', () {
      const e = TraccarException(statusCode: 404, message: 'Not found');
      expect(e.statusCode, 404);
      expect(e.message, 'Not found');
      expect(e.data, isNull);
    });

    test('isUnauthorized is true for 401', () {
      const e = TraccarException(statusCode: 401, message: 'Unauthorized');
      expect(e.isUnauthorized, isTrue);
      expect(e.isForbidden, isFalse);
    });

    test('isForbidden is true for 403', () {
      const e = TraccarException(statusCode: 403, message: 'Forbidden');
      expect(e.isForbidden, isTrue);
      expect(e.isUnauthorized, isFalse);
    });

    test('isNotFound is true for 404', () {
      const e = TraccarException(statusCode: 404, message: 'Not found');
      expect(e.isNotFound, isTrue);
    });

    test('isServerError is true for 500+', () {
      expect(
        const TraccarException(statusCode: 500, message: 'error').isServerError,
        isTrue,
      );
      expect(
        const TraccarException(statusCode: 503, message: 'error').isServerError,
        isTrue,
      );
      expect(
        const TraccarException(statusCode: 200, message: 'ok').isServerError,
        isFalse,
      );
    });

    test('isNetworkError is true when statusCode is null', () {
      const e = TraccarException(message: 'No internet');
      expect(e.isNetworkError, isTrue);
      expect(e.statusCode, isNull);
    });

    test('toString includes statusCode and message', () {
      const e = TraccarException(statusCode: 404, message: 'Not found');
      expect(e.toString(), contains('404'));
      expect(e.toString(), contains('Not found'));
    });

    test('data field stores raw response body', () {
      const e = TraccarException(
        statusCode: 400,
        message: 'Bad request',
        data: {'message': 'Invalid parameter'},
      );
      expect(e.data, isMap);
    });
  });
}
