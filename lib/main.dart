import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final String? token = await UserInfo().getToken();
  print('Token: $token');

  final coffeeNotifier = CoffeeNotifier();

  runApp(MyApp(
    token: token,
    notifier: coffeeNotifier,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final CoffeeNotifier notifier;

  const MyApp({
    super.key,
    required this.token,
    required this.notifier,
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
      home: token == null ? LoginPages(notifier: notifier) : HomePages(notifier: notifier),
    );
  }
}