import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/coffee_repository.dart';

class ProcessPaymentUseCase {
  final CoffeeRepository repository;

  ProcessPaymentUseCase(this.repository);

  Future<Payment> execute(Payment payment) async {
    return await repository.processPayment(payment);
  }
}