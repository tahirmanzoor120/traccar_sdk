import 'package:dio/dio.dart';

import '../models/user.dart';
import 'base_api.dart';

class UsersApi extends BaseApi {
  UsersApi(super.dio);

  Future<List<User>> getUsers({
    String? userId,
    int? limit,
    int? offset,
    String? keyword,
  }) => guard(() async {
    final params = <String, dynamic>{};
    if (userId != null) params['userId'] = userId;
    if (limit != null) params['limit'] = limit;
    if (offset != null) params['offset'] = offset;
    if (keyword != null) params['keyword'] = keyword;
    final response = await dio.get<List<dynamic>>(
      '/users',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<User> createUser(User user) => guard(() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/users',
      data: user.toJson(),
    );
    return User.fromJson(response.data!);
  });

  Future<User> updateUser(int id, User user) => guard(() async {
    final response = await dio.put<Map<String, dynamic>>(
      '/users/$id',
      data: user.toJson(),
    );
    return User.fromJson(response.data!);
  });

  Future<void> deleteUser(int id) =>
      guard(() async => dio.delete<void>('/users/$id'));

  /// Generates a new TOTP secret. Returns the secret string.
  Future<String> generateTotpSecret() => guard(() async {
    final response = await dio.post<String>(
      '/users/totp',
      options: Options(responseType: ResponseType.plain),
    );
    return response.data ?? '';
  });
}
