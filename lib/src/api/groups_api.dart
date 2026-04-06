
import '../models/group.dart';
import 'base_api.dart';

class GroupsApi extends BaseApi {
  GroupsApi(super.dio);

  Future<List<Group>> getGroups({
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
          '/groups',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Group.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Group> createGroup(Group group) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/groups',
          data: group.toJson(),
        );
        return Group.fromJson(response.data!);
      });

  Future<Group> updateGroup(int id, Group group) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/groups/$id',
          data: group.toJson(),
        );
        return Group.fromJson(response.data!);
      });

  Future<void> deleteGroup(int id) =>
      guard(() async => dio.delete<void>('/groups/$id'));
}
