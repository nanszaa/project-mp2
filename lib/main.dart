import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/login_pages.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  
  runApp(MaterialApp(
    title: "Kohi",
    debugShowCheckedModeBanner: false,
    home: token == null ? LoginPages() : HomePages(),
  ));
}