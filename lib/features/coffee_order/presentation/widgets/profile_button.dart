import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final VoidCallback onTap; // Aksi ketika tombol diklik

  const ProfileButtonWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Menjalankan fungsi saat diklik
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300], // Warna latar belakang jika foto kosong
          border: Border.all(color: Colors.brown.shade200, width: 1.5),
        ),
        child: const Icon(
          Icons.person,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}