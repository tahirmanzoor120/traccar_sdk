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
      await client.devices.deleteDevice(createdId!);
    }
    await TestConfig.release();
  });

  group('DevicesApi', skip: TestConfig.skipReason, () {
    test('getDevices returns a list', () async {
      final devices = await client.devices.getDevices();
      expect(devices, isList);
    });

    test('createDevice stores a new device', () async {
      final device = Device(
        name: 'Integration Test Device',
        uniqueId: 'TEST-${DateTime.now().millisecondsSinceEpoch}',
      );
      final created = await client.devices.createDevice(device);
      expect(created.id, isNotNull);
      expect(created.name, device.name);
      createdId = created.id;
    });

    test('getDevices finds created device', () async {
      final devices = await client.devices.getDevices();
      expect(devices.any((d) => d.id == createdId), isTrue);
    });

    test('updateDevice changes name', () async {
      final updated = await client.devices.updateDevice(
        createdId!,
        Device(name: 'Renamed Device', uniqueId: 'TEST-${DateTime.now().millisecondsSinceEpoch}-r'),
      );
      expect(updated.name, 'Renamed Device');
    });

    test('deleteDevice removes device', () async {
      await client.devices.deleteDevice(createdId!);
      final devices = await client.devices.getDevices();
      expect(devices.any((d) => d.id == createdId), isFalse);
      createdId = null;
    });
  });
}
