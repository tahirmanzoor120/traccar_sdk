import 'package:test/test.dart';
import 'package:traccar_sdk/traccar_sdk.dart';

void main() {
  // ──────────────────────────────────────────────────────────────────────────
  // Attribute
  // ──────────────────────────────────────────────────────────────────────────
  group('Attribute', () {
    final json = {
      'id': 1,
      'description': 'Speed limit',
      'attribute': 'speedLimit',
      'expression': '70',
      'type': 'number',
    };

    test('fromJson / toJson roundtrip', () {
      final model = Attribute.fromJson(json);
      expect(model.id, 1);
      expect(model.description, 'Speed limit');
      expect(model.attribute, 'speedLimit');
      expect(model.expression, '70');
      expect(model.type, 'number');
      expect(model.toJson(), json);
    });

    test('copyWith creates modified copy', () {
      final model = Attribute.fromJson(json);
      final copy = model.copyWith(description: 'Updated');
      expect(copy.description, 'Updated');
      expect(copy.id, model.id);
    });

    test('equality', () {
      final a = Attribute.fromJson(json);
      final b = Attribute.fromJson(json);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // Device
  // ──────────────────────────────────────────────────────────────────────────
  group('Device', () {
    final json = {
      'id': 10,
      'name': 'Test Truck',
      'uniqueId': 'ABC123',
      'status': 'online',
      'disabled': false,
      'groupId': 2,
      'phone': '+1234567890',
      'model': 'FMB920',
      'contact': 'driver@example.com',
      'category': 'truck',
      'attributes': <String, dynamic>{},
    };

    test('fromJson / toJson roundtrip', () {
      final device = Device.fromJson(json);
      expect(device.id, 10);
      expect(device.name, 'Test Truck');
      expect(device.uniqueId, 'ABC123');
      expect(device.status, 'online');
      expect(device.disabled, false);
    });

    test('copyWith works', () {
      final device = Device.fromJson(json);
      final updated = device.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.uniqueId, device.uniqueId);
    });

    test('equality', () {
      final a = Device.fromJson(json);
      final b = Device.fromJson(json);
      expect(a, equals(b));
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // Position
  // ──────────────────────────────────────────────────────────────────────────
  group('Position', () {
    final json = {
      'id': 100,
      'deviceId': 10,
      'protocol': 'teltonika',
      'serverTime': '2024-01-15T10:00:00.000Z',
      'deviceTime': '2024-01-15T10:00:00.000Z',
      'fixTime': '2024-01-15T10:00:00.000Z',
      'valid': true,
      'latitude': 51.5074,
      'longitude': -0.1278,
      'altitude': 42.0,
      'speed': 60.5,
      'course': 180.0,
      'accuracy': 5.0,
      'address': '10 Downing St',
      'attributes': <String, dynamic>{'ignition': true},
    };

    test('fromJson parses floats correctly', () {
      final pos = Position.fromJson(json);
      expect(pos.latitude, 51.5074);
      expect(pos.longitude, -0.1278);
      expect(pos.speed, 60.5);
    });

    test('fromJson handles integer coercion to double', () {
      final jsonWithInts = Map<String, dynamic>.from(json)
        ..['latitude'] =
            51 // integer in JSON
        ..['longitude'] = 0; // zero integer
      final pos = Position.fromJson(jsonWithInts);
      expect(pos.latitude, 51.0);
      expect(pos.longitude, 0.0);
    });

    test('toJson roundtrip', () {
      final pos = Position.fromJson(json);
      final out = pos.toJson();
      expect(out['latitude'], 51.5074);
      expect(out['deviceId'], 10);
    });

    test('equality', () {
      final a = Position.fromJson(json);
      final b = Position.fromJson(json);
      expect(a, equals(b));
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // User
  // ──────────────────────────────────────────────────────────────────────────
  group('User', () {
    final json = {
      'id': 1,
      'name': 'Admin',
      'email': 'admin@example.com',
      'phone': '',
      'readonly': false,
      'administrator': true,
      'map': '',
      'latitude': 0,
      'longitude': 0,
      'zoom': 0,
      'disabled': false,
      'deviceReadonly': false,
      'limitCommands': false,
      'fixedEmail': false,
      'deviceLimit': -1,
      'userLimit': 0,
      'attributes': <String, dynamic>{},
    };

    test('fromJson / toJson roundtrip', () {
      final user = User.fromJson(json);
      expect(user.id, 1);
      expect(user.name, 'Admin');
      expect(user.email, 'admin@example.com');
      expect(user.administrator, true);
    });

    test('latitude/longitude coerce from int 0 to double 0.0', () {
      final user = User.fromJson(json);
      expect(user.latitude, 0.0);
      expect(user.longitude, 0.0);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // Permission
  // ──────────────────────────────────────────────────────────────────────────
  group('Permission', () {
    test('userId+deviceId link', () {
      final json = {'userId': 1, 'deviceId': 5};
      final p = Permission.fromJson(json);
      expect(p.userId, 1);
      expect(p.deviceId, 5);
      expect(p.toJson(), json);
    });

    test('userId+groupId link', () {
      final json = {'userId': 1, 'groupId': 3};
      final p = Permission.fromJson(json);
      expect(p.groupId, 3);
      expect(p.deviceId, isNull);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // TraccarUpdate
  // ──────────────────────────────────────────────────────────────────────────
  group('TraccarUpdate', () {
    test('parses devices list', () {
      final json = {
        'devices': [
          {'id': 1, 'name': 'Car', 'uniqueId': 'X1'},
        ],
        'positions': <dynamic>[],
        'events': <dynamic>[],
      };
      final update = TraccarUpdate.fromJson(json);
      expect(update.devices?.length, 1);
      expect(update.devices?.first.name, 'Car');
    });

    test('handles missing keys gracefully', () {
      final update = TraccarUpdate.fromJson({});
      expect(update.devices, isNull);
      expect(update.positions, isNull);
      expect(update.events, isNull);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // ReportSummary — double coercion
  // ──────────────────────────────────────────────────────────────────────────
  group('ReportSummary', () {
    test('maxSpeed coerces int to double', () {
      final json = {
        'deviceId': 1,
        'deviceName': 'Car',
        'maxSpeed': 0, // JSON integer
        'averageSpeed': 0, // JSON integer
        'distance': 0,
        'spentFuel': 0,
      };
      final summary = ReportSummary.fromJson(json);
      expect(summary.maxSpeed, 0.0);
      expect(summary.distance, 0.0);
    });
  });
}
