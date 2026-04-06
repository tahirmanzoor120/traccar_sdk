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
      await client.drivers.deleteDriver(createdId!);
    }
    await TestConfig.release();
  });

  group('DriversApi', skip: TestConfig.skipReason, () {
    test('getDrivers returns a list', () async {
      final list = await client.drivers.getDrivers();
      expect(list, isList);
    });

    test('createDriver stores a driver', () async {
      final driver = Driver(
        name: 'Test Driver',
        uniqueId: 'DRV-${DateTime.now().millisecondsSinceEpoch}',
      );
      final created = await client.drivers.createDriver(driver);
      expect(created.id, isNotNull);
      expect(created.name, 'Test Driver');
      createdId = created.id;
    });

    test('updateDriver changes name', () async {
      final updated = await client.drivers.updateDriver(
        createdId!,
        const Driver(name: 'Renamed Driver', uniqueId: 'DRV-renamed'),
      );
      expect(updated.name, 'Renamed Driver');
    });

    test('deleteDriver removes it', () async {
      await client.drivers.deleteDriver(createdId!);
      final list = await client.drivers.getDrivers();
      expect(list.any((d) => d.id == createdId), isFalse);
      createdId = null;
    });
  });
}
