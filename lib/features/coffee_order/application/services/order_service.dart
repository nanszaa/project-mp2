import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:dio/dio.dart';

class OrderService {
  Future<List<Order>> getOrders() async {
    try {
      final Response response = await ApiClient().get('order');

      dynamic rawData = response.data;
      if (rawData is Map<String, dynamic> && rawData.containsKey('data')) {
        rawData = rawData['data'];
      }

      if (rawData is List) {
        return rawData.map((item) => Order.fromMap(item as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      print('Error getOrder: $e');
      return [];
    }
  }

  Future<Order> create(Order order) async {
    var data = order.toMap();
      final Response response = await ApiClient().post('order', data);
      Order result = Order.fromMap(response.data);
      return result;
  }
}
