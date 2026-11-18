// lib/infrastructure/repositories/coffee_repository_impl.dart
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/CoffeeRepository.dart';
import 'package:dartz/dartz.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  // Catatan: Nanti di sini kita akan menyuntikkan HTTP Client atau Service API dari dosen

  @override
  Future<List<CoffeeItem>> getCoffeeMenu() async {
    // Simulasi data menu kopi (Nanti diganti dengan pemanggilan API dosen)
    await Future.delayed(const Duration(seconds: 1));
    return [
      CoffeeItem(
        id: '1',
        name: 'Caramel Macchiato',
        description: 'Espresso dengan susu segar dan saus karamel manis.',
        price: 32000,
        imageUrl: 'https://images.unsplash.com/photo-1485808191679-edf86b7fd6e9',
        category: 'Espresso',
        isAvailable: true,
      ),
      CoffeeItem(
        id: '2',
        name: 'Caffe Latte',
        description: 'Perpaduan seimbang espresso dan steamed milk.',
        price: 28000,
        imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca',
        category: 'Espresso',
        isAvailable: true,
      ),
    ];
  }

  @override
  Future<Table> scanTable(String tableId) async {
    // Simulasi scan QR Meja
    await Future.delayed(const Duration(milliseconds: 500));
    return Table(
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