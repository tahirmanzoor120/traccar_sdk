import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_api.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? createdId;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async {
    if (createdId != null) {
      await client.users.deleteUser(createdId!);
    }
    await TestConfig.release();
  });

  group('UsersApi', skip: TestConfig.skipReason, () {
    test('getUsers returns at least the admin', () async {
      final users = await client.users.getUsers();
      expect(users.isNotEmpty, isTrue);
      expect(users.any((u) => u.email == TestConfig.testAdminEmail), isTrue);
    });

    test('createUser stores a new user', () async {
      final ts = DateTime.now().millisecondsSinceEpoch;
      final user = User(
        name: 'Test User',
        email: 'testuser_$ts@example.com',
        password: 'password',
      );
      final created = await client.users.createUser(user);
      expect(created.id, isNotNull);
      expect(created.email, user.email);
      createdId = created.id;
    });

    test('updateUser changes name', () async {
      final updated = await client.users.updateUser(
        createdId!,
        User(id: createdId, name: 'Renamed User', email: 'testuser_renamed@example.com'),
      );
      expect(updated.name, 'Renamed User');
    });

    test('deleteUser removes user', () async {
      await client.users.deleteUser(createdId!);
      final users = await client.users.getUsers();
      expect(users.any((u) => u.id == createdId), isFalse);
      createdId = null;
    });
  });
}
