import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';

class Order {
  final String id;
  final String userId;
  final String tableId;
  final List<CoffeeItem> items;
  final double totalPrice;
  final String orderStatus;
  final String notes;
  final Payment? payment;

  Order({
    required this.id,
    required this.userId,
    required this.tableId,
    required this.items,
    required this.totalPrice,
    required this.orderStatus,
    this.notes = '',
    this.payment,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map["id"]?.toString() ?? '',
      userId: map["userId"]?.toString() ?? '',
      tableId: map["tableId"]?.toString() ?? '',
      // Konversi tiap item menjadi CoffeeItem
      items: (map["items"] as List<dynamic>?)
              ?.map((item) => CoffeeItem.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalPrice: (map["totalPrice"] as num?)?.toDouble() ?? 0.0,
      orderStatus: map["orderStatus"]?.toString() ?? '',
      notes: map["notes"]?.toString() ?? '',
      // Konversi payment jika ada
      payment: map["payment"] != null && map["payment"] is Map<String, dynamic>
          ? Payment.fromMap(map["payment"] as Map<String, dynamic>)
          : null,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order.fromMap(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'tableId': tableId,
    // Ubah tiap objek menjadi Map
    'items': items.map((item) => item.toMap()).toList(),
    'totalPrice': totalPrice,
    'orderStatus': orderStatus,
    'notes': notes,
    'payment': payment?.toMap(),
  };

  Map<String, dynamic> toJson() => toMap();
}