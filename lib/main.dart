import 'package:coffee_shop/features/coffee_order/domain/impl/coffee_repository_impl.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/create_order_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/get_menu_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/process_payment_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/scan_table_use_case.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/menu_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:flutter/material.dart';
// Import HomePage dari folder presentation Anda
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';

void main() {
  final repository = CoffeeRepositoryImpl();
  final getMenuUseCase = GetMenuUseCase(repository);
  final scanTableUseCase = ScanTableUseCase(repository);
  final createOrderUseCase = CreateOrderUseCase(repository);
  final processPaymentUseCase = ProcessPaymentUseCase(repository);
  
  runApp(MyApp(
    coffeeNotifier: CoffeeNotifier(
      getMenuUseCase: getMenuUseCase,
      scanTableUseCase: scanTableUseCase,
      createOrderUseCase: createOrderUseCase,
      processPaymentUseCase: processPaymentUseCase,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final CoffeeNotifier coffeeNotifier;

  const MyApp({Key? key, required this.coffeeNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
        useMaterial3: true,
      ),
      home: MenuScreen(notifier: coffeeNotifier),
    );
  }
}