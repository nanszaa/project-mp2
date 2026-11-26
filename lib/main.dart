import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/impl/coffee_repository_impl.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/get_menu_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/scan_table_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/create_order_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/process_payment_use_case.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // 1. Pastikan binding widget terinisialisasi sebelum async call
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Cek token lokal pengguna
  final String? token = await UserInfo().getToken();
  print('Token: $token');

  // 3. Inisialisasi layer Service, Repository, dan Use Cases (Clean Architecture)
  final coffeeService = CoffeeService();
  final repository = CoffeeRepositoryImpl(coffeeService: coffeeService);

  final getMenu = GetMenuUseCase(repository);
  final scanTable = ScanTableUseCase(repository);
  final createOrder = CreateOrderUseCase(repository);
  final processPayment = ProcessPaymentUseCase(repository);

  // 4. Inisialisasi Notifier/State Management
  final coffeeNotifier = CoffeeNotifier(
    getMenuUseCase: getMenu,
    scanTableUseCase: scanTable,
    createOrderUseCase: createOrder,
    processPaymentUseCase: processPayment,
  );

  // 5. Jalankan aplikasi sekali saja dengan MyApp
  runApp(MyApp(
    token: token,
    coffeeNotifier: coffeeNotifier,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final CoffeeNotifier coffeeNotifier;

  const MyApp({
    super.key,
    required this.token,
    required this.coffeeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kohi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB84A0F)),
        useMaterial3: true,
      ),
      // Cek autentikasi: jika token null ke LoginPages, jika ada langsung ke HomePages
      home: token == null ? const LoginPages() : const HomePages(),
    );
  }
}