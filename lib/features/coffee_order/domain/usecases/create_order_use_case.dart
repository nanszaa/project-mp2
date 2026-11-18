import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/coffee_repository.dart';

class CreateOrderUseCase {
  final CoffeeRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Order> execute(Order order) async {
    return await repository.createOrder(order);
  }
}