import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/CoffeeRepository.dart';

class GetMenuUseCase {
  final CoffeeRepository repository;

  GetMenuUseCase(this.repository);

  Future<List<CoffeeItem>> execute() async {
    return await repository.getCoffeeMenu();
  }
}