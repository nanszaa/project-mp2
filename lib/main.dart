import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/menu_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final String? token = await UserInfo().getToken();
  final String? user = await UserInfo().getUserID();
  final String? name = await UserInfo().getUsername();
  final String? member = await UserInfo().getMember();
  print('Token: $token');
  print('User: $user');
  print('Name: $name');
  print('Member: $member');

  final coffeeNotifier = CoffeeNotifier();

  runApp(MyApp(
    token: token,
    user: user,
    name: name,
    member: member,
    notifier: coffeeNotifier,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? user;
  final String? name;
  final String? member;
  final CoffeeNotifier notifier;

  const MyApp({
    super.key,
    required this.token,
    required this.user,
    required this.name,
    required this.member,
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
      home: token == null 
      ? LoginPages(notifier: notifier, token: token, userId: user, username: name, member: member) 
      : HomePages(notifier: notifier, token: token, userId: user, username: name, member: member),
    );
  }
}