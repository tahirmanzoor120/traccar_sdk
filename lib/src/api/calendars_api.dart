
import '../models/calendar.dart';
import 'base_api.dart';

class CalendarsApi extends BaseApi {
  CalendarsApi(super.dio);

  Future<List<Calendar>> getCalendars({
    bool? all,
    int? userId,
    int? limit,
    int? offset,
    String? keyword,
  }) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (all != null) params['all'] = all;
        if (userId != null) params['userId'] = userId;
        if (limit != null) params['limit'] = limit;
        if (offset != null) params['offset'] = offset;
        if (keyword != null) params['keyword'] = keyword;
        final response = await dio.get<List<dynamic>>(
          '/calendars',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Calendar.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Calendar> createCalendar(Calendar calendar) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/calendars',
          data: calendar.toJson(),
        );
        return Calendar.fromJson(response.data!);
      });

  Future<Calendar> updateCalendar(int id, Calendar calendar) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/calendars/$id',
          data: calendar.toJson(),
        );
        return Calendar.fromJson(response.data!);
      });

  Future<void> deleteCalendar(int id) =>
      guard(() async => dio.delete<void>('/calendars/$id'));
}
