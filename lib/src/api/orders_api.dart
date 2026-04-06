
import '../models/order.dart';
import 'base_api.dart';

class OrdersApi extends BaseApi {
  OrdersApi(super.dio);

  Future<List<Order>> getOrders({
    bool? all,
    int? userId,
    bool? excludeAttributes,
    int? limit,
    int? offset,
    String? keyword,
  }) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (all != null) params['all'] = all;
        if (userId != null) params['userId'] = userId;
        if (excludeAttributes != null) {
          params['excludeAttributes'] = excludeAttributes;
        }
        if (limit != null) params['limit'] = limit;
        if (offset != null) params['offset'] = offset;
        if (keyword != null) params['keyword'] = keyword;
        final response = await dio.get<List<dynamic>>(
          '/orders',
          queryParameters: params,
        );
        return (response.data ?? [])
            .map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  Future<Order> createOrder(Order order) =>
      guard(() async {
        final response = await dio.post<Map<String, dynamic>>(
          '/orders',
          data: order.toJson(),
        );
        return Order.fromJson(response.data!);
      });

  Future<Order> updateOrder(int id, Order order) =>
      guard(() async {
        final response = await dio.put<Map<String, dynamic>>(
          '/orders/$id',
          data: order.toJson(),
        );
        return Order.fromJson(response.data!);
      });

  Future<void> deleteOrder(int id) =>
      guard(() async => dio.delete<void>('/orders/$id'));
}
