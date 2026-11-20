import 'package:flutter/material.dart';

// ==============================================================
// 1. PALET WARNA RESMI APLIKASI (AppColors)
// ==============================================================
class AppColors {
  // Warna Identitas Utama Kafe
  static const Color primaryBrown = Color(0xFF4A3319);     // Tombol Pesan Sekarang & Barista Note
  static const Color accentOrange = Color(0xFFB84A0F);     // Badge keranjang, ikon kopi, chip aktif

  // Warna Latar & Aksen Lembut
  static const Color softCream = Color(0xFFFDECD0);        // Banner estimasi waktu, tag menu
  static const Color scaffoldBg = Color(0xFFF9F6F0);       // Background layar menu
  static const Color surfaceBg = Color(0xFFF9F9F9);        // Background layar keranjang & input field
  static const Color imagePlaceholder = Color(0xFFEFECE6); // Background gambar produk kosong
  static const Color borderSubtle = Color(0xFFE0DDD7);     // Garis tepi stepper (- 1 +)

  // Warna Teks & Elemen Netral
  static const Color textPrimary = Color(0xFF1E1E1E);      // Teks judul & harga tebal
  static const Color textSecondary = Color(0xFF757575);    // Teks deskripsi & rincian biaya
  static const Color textHint = Color(0xFF9E9E9E);         // Placeholder input catatan
  static const Color surfaceWhite = Colors.white;          // Warna putih kartu
  static const Color circleButtonBg = Color(0xFFEEEEEE);   // Background tombol bulat header
}

// ==============================================================
// 2. STANDARISASI GAYA TULISAN & FONT (AppTypography)
// ==============================================================
class AppTypography {
  // Judul Besar Halaman (Contoh: "Keranjang Pesanan")
  static const TextStyle pageHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Judul Bagian / Sub-header (Contoh: "Ringkasan Pembayaran", "Pilihan Menu Favorit")
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Nama Produk pada Kartu (Contoh: "Iced Spanish Latte")
  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Label Kategori Kecil (Contoh: "ESPRESSO BAR")
  static const TextStyle categoryLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  // Angka Harga Standar pada Kartu Menu
  static const TextStyle price = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Total Harga Besar pada Bagian Bawah Layar
  static const TextStyle priceTotal = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Teks Deskripsi atau Informasi Tambahan (12px)
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Teks Keterangan Sangat Kecil (Contoh: "Sudah termasuk PB1 & servis")
  static const TextStyle caption = TextStyle(
    fontSize: 10,
    color: AppColors.textSecondary,
  );

  // Teks Tombol Aksi Utama (Contoh: "Pesan Sekarang")
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}