import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/application/services/order_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/impl/coffee_repository_impl.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/get_menu_use_case.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/menu_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/scan_table_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/create_order_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/process_payment_use_case.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? token = await UserInfo().getToken();
  print('Token: $token');

  runApp(MaterialApp(
    title: "Kohi",
    debugShowCheckedModeBanner: false,
    home: token == null ? LoginPages() : HomePages()
    ));
}

// class MyApp extends StatelessWidget {
//   final CoffeeNotifier coffeeNotifier;
//   final String? token;

//   const MyApp({
//     Key? key,
//     required this.coffeeNotifier,
//     this.token,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Coffee Shop App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.brown,
//         scaffoldBackgroundColor: const Color(0xFFF9F9F9),
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
//         useMaterial3: true,
//       ),
//       // Jika token null atau kosong, masuk ke Login; jika ada, langsung ke MenuScreen
//       home: token == null
//         ? LoginPages()
//         : MenuScreen(notifier: coffeeNotifier),
//     );
//   }
// }