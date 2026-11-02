import 'package:coffee_shop/features/coffee_order/domain/entities/cart_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/user.dart';

class Order {
  String id;
  User user;
  TableItem tableItem;
  List<CartItem> items;
  String status;
  DateTime createdAt;

  Order({
    required this.id,
    required this.user,
    required this.tableItem,
    required this.items,
    required this.status,
    required this.createdAt,
  });

  int get totalPrice => items.fold(0, (sum, item) => sum + item.subTotal);
}