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
      await client.attributes.deleteAttribute(createdId!);
    }
    await TestConfig.release();
  });

  group('AttributesApi', skip: TestConfig.skipReason, () {
    test('getAttributes returns a list', () async {
      final list = await client.attributes.getAttributes();
      expect(list, isList);
    });

    test('createAttribute stores a computed attribute', () async {
      const attr = Attribute(
        description: 'Test Attribute',
        attribute: 'testAttr',
        expression: '42',
        type: 'number',
      );
      final created = await client.attributes.createAttribute(attr);
      expect(created.id, isNotNull);
      expect(created.description, 'Test Attribute');
      createdId = created.id;
    });

    test('updateAttribute changes expression', () async {
      final updated = await client.attributes.updateAttribute(
        createdId!,
        const Attribute(
          description: 'Test Attribute',
          attribute: 'testAttr',
          expression: '100',
          type: 'number',
        ),
      );
      expect(updated.expression, '100');
    });

    test('deleteAttribute removes it', () async {
      await client.attributes.deleteAttribute(createdId!);
      final list = await client.attributes.getAttributes();
      expect(list.any((a) => a.id == createdId), isFalse);
      createdId = null;
    });
  });
}
