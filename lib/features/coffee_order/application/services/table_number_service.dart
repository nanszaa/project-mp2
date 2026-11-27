// lib/infrastructure/datasources/coffee_api_service.dart
import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';
import 'package:dio/dio.dart';

class TableNumberService {
  Future<List<TableNumber>> getTable() async {
    try {
      final Response response = await ApiClient().get('table-number');
      final List data = response.data as List;
      List<TableNumber> result = data
          .map((map) => TableNumber.fromMap(map))
          .toList();
      return result;
    } catch (e) {
      print('Error getCoffee: $e');
      return [];
    }
  }

  Future<TableNumber> updateTable(TableNumber item, String id) async {
    var data = item.toMap();
    final Response response = await ApiClient().put('table-number/${id}', data);
    print(response);
    TableNumber result = TableNumber.fromMap(response.data);
    return result;
  }

  Future<TableNumber> getTableById(String id) async {
    final Response response = await ApiClient().get('table-number/${id}');
    TableNumber result = TableNumber.fromMap(response.data);
    return result;
  }

  Future<TableNumber> deleteTable(TableNumber item) async {
    final Response response = await ApiClient().delete(
      'table-number/${item.id}',
    );
    TableNumber result = TableNumber.fromMap(response.data);
    return result;
  }
}
