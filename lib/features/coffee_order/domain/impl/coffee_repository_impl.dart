// lib/infrastructure/repositories/coffee_repository_impl.dart
import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/coffee_repository.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  // Catatan: Nanti di sini kita akan menyuntikkan HTTP Client atau Service API dari dosen
  final CoffeeService coffeeService;

  CoffeeRepositoryImpl({required this.coffeeService});

  @override
  Future<List<CoffeeItem>> getCoffeeMenu() async {
    // Simulasi data menu kopi (Nanti diganti dengan pemanggilan API dosen)
    return await coffeeService.fetchCoffeeMenu();
  }

  @override
  Future<TableNumber> scanTable(String tableId) async {
    // Simulasi scan QR Meja
    await Future.delayed(const Duration(milliseconds: 500));
    return TableNumber(
      id: tableId,
      tableNumber: 'Meja 05',
      isOccupied: false,
    );
  }

  @override
  Future<Order> createOrder(Order order) async {
    // Simulasi membuat pesanan
    await Future.delayed(const Duration(seconds: 1));
    return order;
  }

  @override
  Future<Payment> processPayment(Payment payment) async {
    // Simulasi pembayaran sukses
    await Future.delayed(const Duration(seconds: 1));
    return Payment(
      id: 'PAY-001',
      orderId: payment.orderId,
      amount: payment.amount,
      method: payment.method,
      status: 'Success',
      paymentDate: DateTime.now(),
    );
  }
}