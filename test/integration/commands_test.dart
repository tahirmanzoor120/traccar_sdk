import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? deviceId;
  int? commandId;

  setUpAll(() async {
    client = await TestConfig.setup();
    // Create a device to associate commands with.
    final device = await client.devices.createDevice(
      Device(
        name: 'Cmd Test Device',
        uniqueId: 'CMD-${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    deviceId = device.id;
  });

  tearDownAll(() async {
    if (commandId != null) {
      await client.commands.deleteCommand(commandId!);
    }
    if (deviceId != null) {
      await client.devices.deleteDevice(deviceId!);
    }
    await TestConfig.release();
  });

  group('CommandsApi', skip: TestConfig.skipReason, () {
    test('getCommands returns a list', () async {
      final cmds = await client.commands.getCommands();
      expect(cmds, isList);
    });

    test('createCommand stores a saved command', () async {
      final cmd = Command(
        deviceId: deviceId,
        type: 'engineStop',
        description: 'Test stop',
      );
      final created = await client.commands.createCommand(cmd);
      expect(created.id, isNotNull);
      commandId = created.id;
    });

    test('getCommandTypes returns non-empty list', () async {
      final types = await client.commands.getCommandTypes();
      expect(types, isNotEmpty);
    });
  });
}
