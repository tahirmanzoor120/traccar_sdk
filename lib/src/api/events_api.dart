
import '../models/event.dart';
import 'base_api.dart';

class EventsApi extends BaseApi {
  EventsApi(super.dio);

  Future<Event> getEvent(int id) =>
      guard(() async {
        final response = await dio.get<Map<String, dynamic>>('/events/$id');
        return Event.fromJson(response.data!);
      });
}
