import 'package:flutter/material.dart';
// Import HomePage dari folder presentation Anda
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        // Memperbaiki shorthand enum agar tidak error
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
        useMaterial3: true,
      ),
      // Mengarahkan home ke HomePage kustom Anda
      home: const LoginPages(),
    );
  }
}