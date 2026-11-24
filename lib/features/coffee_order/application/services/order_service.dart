import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderService {
  Future<List<Order>> getOrders() async {
    try {
      final Response response = await ApiClient().get('order');
      final List data = response.data as List;
      List<Order> result = data.map((map) => Order.fromMap(map)).toList();
      return result;
    } catch (e) {
      print('Error getOrders: $e');
      return [];
    }
  }

  Future<bool> createOrder({
    required String userId,
    required String tableId,
    required List<CoffeeItem> items,
    required double totalPrice,
    required String orderStatus,
    Payment? payment,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'userId': userId,
        'tableId': tableId,
        'items': items.map((item) => item.toMap()).toList(),
        'totalPrice': totalPrice,
        'orderStatus': orderStatus,
        if (payment != null) 'payment': payment.toMap(),
      };

      final Response response = await ApiClient().post('order', body);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error createOrder: $e');
      return false;
    }
  }
}
