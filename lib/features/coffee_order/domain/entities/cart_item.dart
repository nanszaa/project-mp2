import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';

class CartItem {
    CoffeeItem coffee;
    int quantity;
    String notes;

    CartItem({
        required this.coffee,
        required this.quantity,
        this.notes = '',
    });

    int get subTotal => coffee.price * quantity;

    CartItem copyWith({
        int? quantity,
        String? notes,
    }) {
        return CartItem(
            coffee: coffee,
            quantity: quantity ?? this.quantity,
            notes: notes ?? this.notes,
        );
    }
}