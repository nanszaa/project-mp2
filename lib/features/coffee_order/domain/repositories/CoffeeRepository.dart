import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table.dart';

abstract class CoffeeRepository {
  Future<List<CoffeeItem>> getCoffeeMenu();
  Future<Table> scanTable(String tableId);
  Future<Order> createOrder(Order order);
  Future<Payment> processPayment(Payment payment);
}
