
import '../models/notification.dart';
import '../models/notification_message.dart';
import '../models/notification_type.dart';
import 'base_api.dart';

class NotificationsApi extends BaseApi {
  NotificationsApi(super.dio);

  Future<List<Notification>> getNotifications({
    bool? all,
    int? userId,
    int? deviceId,
    int? groupId,
    bool? refresh,
    int? limit,
    int? offset,
    String? keyword,
  }) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (all != null) params['all'] = all;
        if (userId != null) params['userId'] = userId;
        if (deviceId != null) params['deviceId'] = deviceId;
        if (groupId != null) params['groupId'] = groupId;
        if (refresh != null) params['refresh'] = refresh;
        if (limit != null) params['limit'] = limit;
        if (offset != null) params['offset'] = offset;
        if (keyword != null) params['keyword'] = keyword;
        final response = await dio.get<List<dynamic>>(
          '/notifications',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Notification.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Notification> createNotification(Notification notification) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/notifications',
          data: notification.toJson(),
        );
        return Notification.fromJson(response.data!);
      });

  Future<Notification> updateNotification(
    int id,
    Notification notification,
  ) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/notifications/$id',
          data: notification.toJson(),
        );
        return Notification.fromJson(response.data!);
      });

  Future<void> deleteNotification(int id) =>
      guard(() async => dio.delete<void>('/notifications/$id'));

  Future<List<NotificationType>> getNotificationTypes() =>
      guard(() async {
        final response =
            await dio.get<List<dynamic>>('/notifications/types');
        return (response.data ?? [])
            .map((e) =>
                NotificationType.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  /// Sends a test notification to the current user via configured channels.
  Future<void> sendTestNotification() =>
      guard(() async => dio.post<void>('/notifications/test'));

  /// Sends a custom notification via [notificator] (e.g. `mail`, `web`).
  ///
  /// [userIds] optional — if empty, sends to all permitted users.
  Future<void> sendCustomNotification(
    String notificator,
    NotificationMessage message, {
    List<int>? userIds,
  }) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (userIds != null && userIds.isNotEmpty) {
          params['userId'] = userIds;
        }
        await dio.post<void>(
          '/notifications/send/$notificator',
          data: message.toJson(),
          queryParameters: params,
        );
      });
}
