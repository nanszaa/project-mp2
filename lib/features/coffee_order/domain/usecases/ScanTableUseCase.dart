import 'package:coffee_shop/features/coffee_order/domain/entities/table.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/CoffeeRepository.dart';

class ScanTableUseCase {
  final CoffeeRepository repository;

  ScanTableUseCase(this.repository);

  Future<Table> execute(String tableId) async {
    return await repository.scanTable(tableId);
  }
}