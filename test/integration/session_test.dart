import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_api/traccar_api.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async => TestConfig.release());

  group('SessionApi', skip: TestConfig.skipReason, () {
    test('getSession(token:) returns test-admin user', () async {
      // Pass the token explicitly — server resolves the user without a session
      // cookie, so this works with token-auth clients.
      final me = await client.session.getSession(token: TestConfig.testToken);
      expect(me.email, TestConfig.testAdminEmail);
      expect(me.id, isNotNull);
      expect(me.id, TestConfig.testAdminId);
    });

    test('generateToken returns non-empty token string', () async {
      // Login via cookie to establish a server-side session, then generate token.
      await client.session.login(
        email: TestConfig.testAdminEmail,
        password: TestConfig.testAdminPassword,
      );
      final token = await client.session.generateToken(
        expiration: DateTime.now().add(const Duration(hours: 1)),
      );
      expect(token, isNotEmpty);
    });

    test('logout and re-login succeeds', () async {
      await client.session.login(
        email: TestConfig.testAdminEmail,
        password: TestConfig.testAdminPassword,
      );
      await expectLater(client.session.logout(), completes);
      // Re-establish session so subsequent tests are unaffected.
      await client.session.login(
        email: TestConfig.testAdminEmail,
        password: TestConfig.testAdminPassword,
      );
    });
  });
}
