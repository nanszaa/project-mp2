import 'package:coffee_shop/features/coffee_order/application/services/login_service.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/register_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/scanner_pages.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F6F0,
      ), // Warna latar belakang krem hangat
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 1. Logo & Badge Atas
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDECD0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Color(0xFFB84A0F),
                      size: 36,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.table_bar,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Judul & Subjudul
              const Text(
                'Kohi',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Dine-in made effortless. Sign in to sync your party, split tabs, and reorder in seconds.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 24),

              // 2. Kotak Form Putih (Card)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: [
                        _nameTextField(),
                        const SizedBox(height: 16),
                        _passwordTextField(),
                        const SizedBox(height: 16),
                        _tombolSignIn(),
                        const SizedBox(height: 16),
                        _tombolSignUp(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      controller: _nameCtrl,
      decoration: InputDecoration(
        labelText: 'Name',
        prefixIcon: const Icon(Icons.person, color: Colors.grey, size: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordCtrl,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.password, color: Colors.grey, size: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _tombolSignUp() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: const Text("Sign up"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPages()),
          );
        },
      ),
    );
  }

  Widget _tombolSignIn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Sign in"),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String name = _nameCtrl.text;
            String password = _passwordCtrl.text;

            bool isSuccess = await LoginService().login(name, password);

            if (isSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePages()),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('Username atau password tidak valid.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
