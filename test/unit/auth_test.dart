import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/src/interceptors/traccar_auth_interceptor.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

void main() {
  group('TraccarAuth', () {
    test('TraccarBasicAuth holds credentials', () {
      const auth = TraccarBasicAuth(email: 'user@example.com', password: 's3cr3t');
      expect(auth.email, 'user@example.com');
      expect(auth.password, 's3cr3t');
    });

    test('TraccarBasicAuth toString redacts password', () {
      const auth = TraccarBasicAuth(email: 'user@example.com', password: 's3cr3t');
      // toString should NOT expose the password
      expect(auth.toString(), isNot(contains('s3cr3t')));
    });

    test('TraccarTokenAuth holds token', () {
      const auth = TraccarTokenAuth(token: 'abc123');
      expect(auth.token, 'abc123');
    });

    test('Auth types are distinct subclasses', () {
      const basic = TraccarBasicAuth(email: 'a@b.com', password: 'p');
      const token = TraccarTokenAuth(token: 't');
      expect(basic, isA<TraccarBasicAuth>());
      expect(token, isA<TraccarTokenAuth>());
    });
  });

  group('TraccarAuthInterceptor', () {
    late RequestOptions options;

    setUp(() {
      options = RequestOptions(path: '/test');
    });

    test('sets Basic header for TraccarBasicAuth', () {
      const auth = TraccarBasicAuth(email: 'user@test.com', password: 'pass');
      final interceptor = TraccarAuthInterceptor(auth);

      interceptor.onRequest(
        options,
        RequestInterceptorHandler(),
      );

      final expectedCredentials =
          base64Encode(utf8.encode('user@test.com:pass'));
      expect(
        options.headers['Authorization'],
        'Basic $expectedCredentials',
      );
    });

    test('sets Bearer header for TraccarTokenAuth', () {
      const auth = TraccarTokenAuth(token: 'mytoken123');
      final interceptor = TraccarAuthInterceptor(auth);

      interceptor.onRequest(
        options,
        RequestInterceptorHandler(),
      );

      expect(options.headers['Authorization'], 'Bearer mytoken123');
    });
  });
}
