import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_api/traccar_api.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? createdId;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async {
    if (createdId != null) {
      await client.maintenance.deleteMaintenance(createdId!);
    }
    await TestConfig.release();
  });

  group('MaintenanceApi', skip: TestConfig.skipReason, () {
    test('getMaintenances returns a list', () async {
      final list = await client.maintenance.getMaintenance();
      expect(list, isList);
    });

    test('createMaintenance stores a maintenance item', () async {
      const item = Maintenance(
        name: 'Oil Change',
        type: 'totalDistance',
        start: 5000.0,
        period: 10000.0,
      );
      final created = await client.maintenance.createMaintenance(item);
      expect(created.id, isNotNull);
      expect(created.name, 'Oil Change');
      createdId = created.id;
    });

    test('updateMaintenance changes name', () async {
      final updated = await client.maintenance.updateMaintenance(
        createdId!,
        const Maintenance(
          name: 'Tyre Rotation',
          type: 'totalDistance',
          start: 5000.0,
          period: 10000.0,
        ),
      );
      expect(updated.name, 'Tyre Rotation');
    });

    test('deleteMaintenance removes it', () async {
      await client.maintenance.deleteMaintenance(createdId!);
      final list = await client.maintenance.getMaintenance();
      expect(list.any((m) => m.id == createdId), isFalse);
      createdId = null;
    });
  });
}
