import '../models/permission.dart';
import 'base_api.dart';

class PermissionsApi extends BaseApi {
  PermissionsApi(super.dio);

  /// Fetches permission links between two object types.
  ///
  /// Provide exactly two `*Id` query parameters matching the [Permission]
  /// shape (e.g. `deviceId` and `geofenceId`). Use `0` on a side to mean
  /// "any"; at least one side must be non-zero.
  Future<List<Permission>> getPermissions(Map<String, int> query) =>
      guard(() async {
        final response = await dio.get<List<dynamic>>(
          '/permissions',
          queryParameters: query,
        );
        return (response.data ?? [])
            .map((e) => Permission.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<void> linkObjects(Permission permission) => guard(
    () async => dio.post<void>('/permissions', data: permission.toJson()),
  );

  Future<void> unlinkObjects(Permission permission) => guard(
    () async => dio.delete<void>('/permissions', data: permission.toJson()),
  );

  /// Links multiple object pairs in a single request.
  Future<void> linkObjectsBulk(List<Permission> permissions) => guard(
    () async => dio.post<void>(
      '/permissions/bulk',
      data: permissions.map((p) => p.toJson()).toList(),
    ),
  );

  /// Unlinks multiple object pairs in a single request.
  Future<void> unlinkObjectsBulk(List<Permission> permissions) => guard(
    () async => dio.delete<void>(
      '/permissions/bulk',
      data: permissions.map((p) => p.toJson()).toList(),
    ),
  );
}
