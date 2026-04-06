import 'package:flutter_test/flutter_test.dart';
import 'package:traccar_sdk/traccar_api.dart';

import 'test_config.dart';

void main() {
  late TraccarClient client;
  int? createdId;

  setUpAll(() async {
    client = await TestConfig.setup();
  });

  tearDownAll(() async {
    if (createdId != null) {
      await client.notifications.deleteNotification(createdId!);
    }
    await TestConfig.release();
  });

  group('NotificationsApi', skip: TestConfig.skipReason, () {
    test('getNotifications returns a list', () async {
      final list = await client.notifications.getNotifications();
      expect(list, isList);
    });

    test('getNotificationTypes returns non-empty list', () async {
      final types = await client.notifications.getNotificationTypes();
      expect(types, isNotEmpty);
    });

    test('createNotification stores a notification', () async {
      const notification = Notification(
        type: 'deviceOnline',
        notificators: 'web',
        always: true,
      );
      final created =
          await client.notifications.createNotification(notification);
      expect(created.id, isNotNull);
      createdId = created.id;
    });

    test('updateNotification modifies type', () async {
      final updated = await client.notifications.updateNotification(
        createdId!,
        const Notification(type: 'deviceOffline', notificators: 'web', always: true),
      );
      expect(updated.type, 'deviceOffline');
    });

    test('deleteNotification removes it', () async {
      await client.notifications.deleteNotification(createdId!);
      final list = await client.notifications.getNotifications();
      expect(list.any((n) => n.id == createdId), isFalse);
      createdId = null;
    });
  });
}
