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
      await client.geofences.deleteGeofence(createdId!);
    }
    await TestConfig.release();
  });

  group('GeofencesApi', skip: TestConfig.skipReason, () {
    test('getGeofences returns a list', () async {
      final list = await client.geofences.getGeofences();
      expect(list, isList);
    });

    test('createGeofence stores a new geofence', () async {
      const area = 'CIRCLE (51.5 -0.12, 500)';
      const geofence = Geofence(name: 'Test Fence', area: area);
      final created = await client.geofences.createGeofence(geofence);
      expect(created.id, isNotNull);
      expect(created.name, 'Test Fence');
      expect(created.area, area);
      createdId = created.id;
    });

    test('updateGeofence changes name', () async {
      final updated = await client.geofences.updateGeofence(
        createdId!,
        const Geofence(name: 'Renamed Fence', area: 'CIRCLE (51.5 -0.12, 500)'),
      );
      expect(updated.name, 'Renamed Fence');
    });

    test('deleteGeofence removes it', () async {
      await client.geofences.deleteGeofence(createdId!);
      final list = await client.geofences.getGeofences();
      expect(list.any((g) => g.id == createdId), isFalse);
      createdId = null;
    });
  });
}
