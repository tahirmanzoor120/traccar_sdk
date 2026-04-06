
import '../models/permission.dart';
import 'base_api.dart';

class PermissionsApi extends BaseApi {
  PermissionsApi(super.dio);

  Future<void> linkObjects(Permission permission) =>
      guard(() async => dio.post<void>(
            '/permissions',
            data: permission.toJson(),
          ));

  Future<void> unlinkObjects(Permission permission) =>
      guard(() async => dio.delete<void>(
            '/permissions',
            data: permission.toJson(),
          ));
}
