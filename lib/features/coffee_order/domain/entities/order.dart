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

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map["id"]?.toString() ?? '',
      userId: map["userId"]?.toString() ?? '',
      tableId: map["tableId"]?.toString() ?? '',
      items: map["items"] ?? [],
      totalPrice: (map["totalPrice"] as num?)?.toDouble() ?? 0.0,
      orderStatus: map["orderStatus"]?.toString() ?? '',
      payment: map["payment"],
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order.fromMap(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'tableId': tableId,
    'items': items,
    'totalPrice': totalPrice,
    'orderStatus': orderStatus,
    'payment': payment,
  };

  Map<String, dynamic> toJson() => toMap();
}
