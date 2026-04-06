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
      await client.orders.deleteOrder(createdId!);
    }
    await TestConfig.release();
  });

  group('OrdersApi', skip: TestConfig.skipReason, () {
    test('getOrders returns a list', () async {
      final list = await client.orders.getOrders();
      expect(list, isList);
    });

    test('createOrder stores an order', () async {
      final order = Order(
        uniqueId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        description: 'Integration test order',
        fromAddress: '1 Start St',
        toAddress: '2 End Ave',
      );
      final created = await client.orders.createOrder(order);
      expect(created.id, isNotNull);
      expect(created.description, 'Integration test order');
      createdId = created.id;
    });

    test('updateOrder changes description', () async {
      final updated = await client.orders.updateOrder(
        createdId!,
        const Order(
          uniqueId: 'ORD-updated',
          description: 'Updated description',
          fromAddress: '1 Start St',
          toAddress: '2 End Ave',
        ),
      );
      expect(updated.description, 'Updated description');
    });

    test('deleteOrder removes it', () async {
      await client.orders.deleteOrder(createdId!);
      final list = await client.orders.getOrders();
      expect(list.any((o) => o.id == createdId), isFalse);
      createdId = null;
    });
  });
}
