import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/coffee_repository.dart';

class ScanTableUseCase {
  final CoffeeRepository repository;

  ScanTableUseCase(this.repository);

  Future<TableNumber> execute(String tableId) async {
    return await repository.scanTable(tableId);
  }
}