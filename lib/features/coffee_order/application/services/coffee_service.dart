// lib/infrastructure/datasources/coffee_api_service.dart
import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:dio/dio.dart';

class CoffeeService {
  Future<List<CoffeeItem>> getCoffee() async {
    try {
      // 1. Perbaiki typo: gunakan 'coffee-item'
      final Response response = await ApiClient().get('coffee-item');
      
      print('STATUS API: ${response.statusCode}');
      print('RESPON API: ${response.data}');

      // 2. Antisipasi jika data dibungkus map atau langsung list
      dynamic rawData = response.data;
      if (rawData is Map<String, dynamic> && rawData.containsKey('data')) {
        rawData = rawData['data'];
      }

      if (rawData is List) {
        List<CoffeeItem> result = rawData
            .map((map) => CoffeeItem.fromMap(map as Map<String, dynamic>))
            .toList();
        print('BERHASIL PARSING: ${result.length} item ditemukan');
        return result;
      }

      return [];
    } catch (e) {
      print('Error getCoffee: $e');
      return [];
    }
  }

  Future<CoffeeItem> updateCoffee(CoffeeItem item, String id) async {
    var data = item.toMap();
    final Response response = await ApiClient().put('coffee-item/$id', data);
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }

  Future<CoffeeItem> getCoffeeById(String id) async {
    final Response response = await ApiClient().get('coffee-item/$id');
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }

  Future<CoffeeItem> deleteCoffee(CoffeeItem item) async {
    final Response response = await ApiClient().delete('coffee-item/${item.id}');
    CoffeeItem result = CoffeeItem.fromMap(response.data);
    return result;
  }
}