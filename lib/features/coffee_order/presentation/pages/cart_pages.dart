import 'package:flutter/material.dart';

class CartPages extends StatefulWidget {
  const CartPages({super.key});

  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  // Contoh kuantitas item dummy
  int qty1 = 1;
  int qty2 = 1;

  final int price1 = 35000;
  final int price2 = 30000;

  @override
  Widget build(BuildContext context) {
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

              // 2. Cart Title & Table Info
              _buildCartHeader(),
              const SizedBox(height: 16),

              // 3. List of Cart Items
              _buildCartItemCard(
                title: 'Iced Spanish Latte',
                variants: 'Regular • Less Ice • Oat Milk',
                price: price1,
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
                variants: 'Warmed • Extra Flakes',
                price: price2,
                quantity: qty2,
                onAdd: () => setState(() => qty2++),
                onMinus: () => setState(() {
                  if (qty2 > 1) qty2--;
                }),
                onDelete: () {},
              ),
              const SizedBox(height: 16),

              // 4. Notes to Barista
              _buildBaristaNotesBox(),
              const SizedBox(height: 16),

              // 5. Payment Summary
              _buildPaymentSummary(subtotal),
              const SizedBox(height: 16),

              // 6. Estimated Time Banner
              _buildEstTimeBanner(),
              const SizedBox(height: 24),

              // 7. Checkout Button
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
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.search, size: 20, color: Colors.black87),
            ),
          ],
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
                onPressed: () {},
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

  Widget _buildCartItemCard({
    required String title,
    required String variants,
    required int price,
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onMinus,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.coffee, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    InkWell(
                      onTap: onDelete,
                      child: const Icon(Icons.close, size: 16, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  variants,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp $price',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onMinus,
                            child: const Icon(Icons.remove, size: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          InkWell(
                            onTap: onAdd,
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
              Text('Rp $subtotal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
                'Rp $subtotal',
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
                'Rp $subtotal',
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