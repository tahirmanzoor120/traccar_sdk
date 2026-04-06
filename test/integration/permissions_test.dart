import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_api/traccar_api.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  late int userId;
  int? deviceId;

  setUpAll(() async {
    client = await TestConfig.setup();
    userId = TestConfig.testAdminId;

    // Create a device to link.
    final device = await client.devices.createDevice(
      Device(
        name: 'Perm Test Device',
        uniqueId: 'PERM-${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    deviceId = device.id;
  });

  tearDownAll(() async {
    if (deviceId != null) {
      await client.devices.deleteDevice(deviceId!);
    }
    await TestConfig.release();
  });

  group('PermissionsApi', skip: TestConfig.skipReason, () {
    test('linkObjects (user → device) succeeds', () async {
      final permission = Permission(userId: userId, deviceId: deviceId);
      await expectLater(
        client.permissions.linkObjects(permission),
        completes,
      );
    });

    test('unlinkObjects (user → device) succeeds', () async {
      final permission = Permission(userId: userId, deviceId: deviceId);
      await expectLater(
        client.permissions.unlinkObjects(permission),
        completes,
      );
    });
  });
}
