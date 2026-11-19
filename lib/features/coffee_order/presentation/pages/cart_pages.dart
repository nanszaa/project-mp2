import 'package:flutter/material.dart';
// Impor helper format rupiah yang sudah kita buat
import 'package:coffee_shop/features/coffee_order/presentation/utils/currency_formatter.dart';

class CartPages extends StatefulWidget {
  const CartPages({super.key});

  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  // Jumlah kuantitas pesanan awal
  int qty1 = 1;
  int qty2 = 1;

  final int price1 = 35000;
  final int price2 = 30000;

  @override
  Widget build(BuildContext context) {
    // Menghitung subtotal secara otomatis berdasarkan jumlah pesanan
    int subtotal = (price1 * qty1) + (price2 * qty2);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar / Header
              _buildTopBar(),
              const SizedBox(height: 16),

              // 2. Info Keranjang & Meja
              _buildCartHeader(),
              const SizedBox(height: 16),

              // ==============================================================
              // [PERUBAHAN BARU 1: DAFTAR MENU DENGAN KATEGORI (TANPA CATATAN)]
              // ==============================================================
              _buildCartItemCard(
                title: 'Iced Spanish Latte',
                category: 'ESPRESSO BAR', // Menggantikan catatan varian dengan kategori
                price: price1,
                imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500',
                quantity: qty1,
                onAdd: () => setState(() => qty1++),
                onMinus: () => setState(() {
                  if (qty1 > 1) qty1--;
                }),
                onDelete: () {},
              ),
              const SizedBox(height: 12),
              _buildCartItemCard(
                title: 'Almond Croissant',
                category: 'FRESH BAKE', // Menggantikan catatan varian dengan kategori
                price: price2,
                imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500',
                quantity: qty2,
                onAdd: () => setState(() => qty2++),
                onMinus: () => setState(() {
                  if (qty2 > 1) qty2--;
                }),
                onDelete: () {},
              ),
              const SizedBox(height: 16),

              // ==============================================================
              // [SATU-SATUNYA TEMPAT CATATAN: CATATAN KE BARISTA]
              // ==============================================================
              _buildBaristaNotesBox(),
              const SizedBox(height: 16),

              // 5. Ringkasan Pembayaran
              _buildPaymentSummary(subtotal),
              const SizedBox(height: 16),

              // 6. Estimasi Waktu Penyajian
              _buildEstTimeBanner(),
              const SizedBox(height: 24),

              // 7. Tombol Pesan Sekarang
              _buildCheckoutButton(subtotal),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.coffee, color: Color(0xFF4A3319), size: 20),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kohi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Pesanan', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: const Icon(Icons.search, size: 20, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildCartHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Keranjang Pesanan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  '• Dine-in • Meja 04',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFDECD0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            '2 Menu',
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // ==============================================================
  // [PERUBAHAN BARU 2: PARAMETER VARIANTS DIHAPUS, DIGANTI CATEGORY]
  // ==============================================================
  Widget _buildCartItemCard({
    required String title,
    required String category, // Parameter baru yang lebih rapi
    required num price,
    String imageUrl = '',
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onMinus,
    required VoidCallback onDelete,
  }) {
    final formattedPrice = formatRupiah(price);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Gambar Produk dengan Fallback Ikon
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFFEFECE6),
                      child: const Icon(Icons.coffee, color: Colors.grey),
                    ),
                  )
                : Container(
                    width: 64,
                    height: 64,
                    color: const Color(0xFFEFECE6),
                    child: const Icon(Icons.coffee, color: Colors.grey),
                  ),
          ),
          const SizedBox(width: 12),

          // 2. Rincian Nama, Kategori, dan Harga
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                // Menampilkan Kategori Produk sebagai pengganti catatan varian
                if (category.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  formattedPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // 3. Tombol Hapus (x) dan Stepper Kuantitas (- qty +)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: onDelete,
                child: const Icon(Icons.close, size: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F6F0),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0DDD7)),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onMinus,
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Icon(Icons.remove, size: 14, color: Colors.black87),
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    InkWell(
                      onTap: onAdd,
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Icon(Icons.add, size: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bagian Catatan Tunggal Khusus ke Barista
  Widget _buildBaristaNotesBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.edit_note, size: 18, color: Colors.black87),
                  SizedBox(width: 6),
                  Text('Catatan ke Barista', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Text('Opsional', style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: 2,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Contoh: Pisahkan gula untuk latte, croissant dipanaskan sedang...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 11),
              filled: true,
              fillColor: const Color(0xFFF9F9F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(int subtotal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Ringkasan Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Icon(Icons.receipt_long_outlined, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal (2 Item)', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(formatRupiah(subtotal), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Pajak & Layanan (10%)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                    child: const Text('Termasuk', style: TextStyle(fontSize: 9, color: Colors.black54)),
                  ),
                ],
              ),
              const Text('Rp 0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.black12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 2),
                  Text('Sudah termasuk PB1 & servis', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              Text(
                formatRupiah(subtotal),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstTimeBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECD0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.brown),
              SizedBox(width: 8),
              Text('Estimasi Pembuatan', style: TextStyle(fontSize: 11, color: Colors.brown, fontWeight: FontWeight.w500)),
            ],
          ),
          Text('~ 6 - 8 Menit', style: TextStyle(fontSize: 11, color: Colors.brown, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(int subtotal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3319),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.bolt, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Pesan Sekarang',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                formatRupiah(subtotal),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}