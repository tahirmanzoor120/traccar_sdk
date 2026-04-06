import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? createdId;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async {
    if (createdId != null) {
      await client.groups.deleteGroup(createdId!);
    }
    await TestConfig.release();
  });

  group('GroupsApi', skip: TestConfig.skipReason, () {
    test('getGroups returns a list', () async {
      final groups = await client.groups.getGroups();
      expect(groups, isList);
    });

    test('createGroup stores a new group', () async {
      const group = Group(name: 'Integration Test Group');
      final created = await client.groups.createGroup(group);
      expect(created.id, isNotNull);
      expect(created.name, 'Integration Test Group');
      createdId = created.id;
    });

    test('updateGroup changes name', () async {
      final updated = await client.groups.updateGroup(
        createdId!,
        Group(id: createdId, name: 'Renamed Group'),
      );
      expect(updated.name, 'Renamed Group');
    });

    test('deleteGroup removes the group', () async {
      await client.groups.deleteGroup(createdId!);
      final groups = await client.groups.getGroups();
      expect(groups.any((g) => g.id == createdId), isFalse);
      createdId = null;
    });
  });
}
