// lib/infrastructure/datasources/coffee_api_service.dart
import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:dio/dio.dart';

class CoffeeService {
  Future<List<CoffeeItem>> getCoffee() async {
    try {
      final Response response = await ApiClient().get('coffe-item');
      final List data = response.data as List;
      List<CoffeeItem> result = data.map((map) => CoffeeItem.fromMap(map)).toList();
      return result;
    } catch (e) {
      print('Error getCoffee: $e');
      return [];
    }
  }

  Future<CoffeeItem> updateCoffee(CoffeeItem item, String id) async {
    var data = item.toMap();
    final Response response = await ApiClient().put('coffee-item/${id}', data);
    print(response);
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }

  Future<CoffeeItem> getCoffeeById(String id) async {
    final Response response = await ApiClient().get('coffee-item/${id}');
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }

  Future<CoffeeItem> deleteCoffee(CoffeeItem item) async {
    final Response response = await ApiClient().delete('coffe-item/${item.id}');
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }
}
