import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';

class Order {
  final String id;
  final String userId;
  final String tableId;
  final List<CoffeeItem> items;
  final double totalPrice;
  final String orderStatus;
  final Payment? payment;

  Order({
    required this.id,
    required this.userId,
    required this.tableId,
    required this.items,
    required this.totalPrice,
    required this.orderStatus,
    this.payment,
  });
}
