import '../models/attribute.dart';
import 'base_api.dart';

class AttributesApi extends BaseApi {
  AttributesApi(super.dio);

  Future<List<Attribute>> getAttributes({
    bool? all,
    int? userId,
    int? deviceId,
    int? groupId,
    bool? refresh,
    int? limit,
    int? offset,
    String? keyword,
  }) => guard(() async {
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
      '/attributes/computed',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<Attribute> createAttribute(Attribute attribute) => guard(() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/attributes/computed',
      data: attribute.toJson(),
    );
    return Attribute.fromJson(response.data!);
  });

  Future<Attribute> updateAttribute(int id, Attribute attribute) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/attributes/computed/$id',
          data: attribute.toJson(),
        );
        return Attribute.fromJson(response.data!);
      });

  Future<void> deleteAttribute(int id) =>
      guard(() async => dio.delete<void>('/attributes/computed/$id'));
}
