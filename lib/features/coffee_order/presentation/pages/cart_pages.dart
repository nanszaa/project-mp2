import 'package:coffee_shop/features/coffee_order/presentation/pages/home_pages.dart';
import 'package:flutter/material.dart';

// [1. IMPORT ENTITAS, NOTIFIER, DAN HELPER FORMAT RUPIAH]
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:coffee_shop/features/coffee_order/presentation/utils/currency_formatter.dart';

class CartPages extends StatefulWidget {
  // Menerima notifier langsung dari halaman pemanggil (MenuScreen)
  final CoffeeNotifier notifier;

  const CartPages({Key? key, required this.notifier}) : super(key: key);

  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  // Controller untuk membaca teks dari kotak Catatan ke Barista
  final TextEditingController _baristaNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dengarkan setiap ada perubahan data keranjang pada CoffeeNotifier
    widget.notifier.addListener(_onCartStateChanged);
  }

  @override
  void dispose() {
    // Lepaskan listener dan controller untuk mencegah kebocoran memori
    widget.notifier.removeListener(_onCartStateChanged);
    _baristaNotesController.dispose();
    super.dispose();
  }

  // Fungsi sinkronisasi: Memperbarui tampilan saat item ditambah/dikurang/dihapus
  void _onCartStateChanged() {
    if (!mounted) return;
    setState(() {});
  }

  // ==============================================================
  // LOGIKA PENGELOMPOKAN MENU & KUANTITAS
  // ==============================================================

  // Menghitung berapa kali tiap menu dimasukkan ke dalam keranjang
  Map<String, int> _getItemQuantities() {
    final Map<String, int> quantities = {};
    for (var item in widget.notifier.cart) {
      quantities[item.id] = (quantities[item.id] ?? 0) + 1;
    }
    return quantities;
  }

  // Mengambil daftar menu unik tanpa duplikasi kartu
  List<CoffeeItem> _getUniqueCartItems() {
    final Map<String, CoffeeItem> uniqueMap = {};
    for (var item in widget.notifier.cart) {
      uniqueMap[item.id] = item;
    }
    return uniqueMap.values.toList();
  }

  // Menghapus seluruh porsi suatu menu dari keranjang (untuk tombol tanda silang 'x')
  void _deleteEntireItemFromCart(CoffeeItem item) {
    while (widget.notifier.cart.any((element) => element.id == item.id)) {
      widget.notifier.removeFromCart(
        widget.notifier.cart.firstWhere((element) => element.id == item.id),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final uniqueItems = _getUniqueCartItems();
    final quantities = _getItemQuantities();
    final double subtotal = widget.notifier.totalPrice;
    final int totalMenuCount = widget.notifier.cart.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: uniqueItems.isEmpty
            // Jika keranjang kosong, tampilkan layar Empty State
            ? _buildEmptyState()
            // Jika ada menu, tampilkan rincian pesanan
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Atas
                    _buildTopBar(),
                    const SizedBox(height: 16),

                    // 2. Info Keranjang & Meja
                    _buildCartHeader(totalMenuCount),
                    const SizedBox(height: 16),

                    // 3. Daftar Kartu Menu Dinamis
                    ...uniqueItems.map((item) {
                      final qty = quantities[item.id] ?? 1;
                      return _buildCartItemCard(
                        item: item,
                        quantity: qty,
                        onAdd: () => widget.notifier.addToCart(item),
                        onMinus: () => widget.notifier.removeFromCart(item),
                        onDelete: () => _deleteEntireItemFromCart(item),
                      );
                    }).toList(),

                    const SizedBox(height: 16),

                    // 4. Catatan ke Barista
                    _buildBaristaNotesBox(),
                    const SizedBox(height: 16),

                    // 5. Ringkasan Pembayaran dengan formatRupiah
                    _buildPaymentSummary(subtotal, totalMenuCount),
                    const SizedBox(height: 16),

                    // 6. Estimasi Waktu
                    _buildEstTimeBanner(),
                    const SizedBox(height: 24),

                    // 7. Tombol Pesan Sekarang
                    _checkoutBtn(subtotal),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  // ==============================================================
  // WIDGET-WIDGET TAMPILAN (KOMPONEN UI)
  // ==============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.brown[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: Color(0xFFB84A0F),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keranjangmu Masih Kosong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Belum ada menu yang kamu pilih. Yuk, temukan aneka kopi dan roti lezat di menu!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A3319),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Lihat Menu Kopi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
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
              child: const Icon(
                Icons.coffee,
                color: Color(0xFF4A3319),
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kohi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Pesanan',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
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

  Widget _buildCartHeader(int totalItems) {
    final tableLabel = widget.notifier.activeTable?.tableNumber ?? 'Meja 04';

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
                  '• Dine-in • $tableLabel',
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
          child: Text(
            '$totalItems Menu',
            style: const TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemCard({
    required CoffeeItem item,
    required int quantity,
    required VoidCallback onAdd,
    required VoidCallback onMinus,
    required VoidCallback onDelete,
  }) {
    final formattedPrice = formatRupiah(item.price);

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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.imageUrl.isNotEmpty
                ? Image.network(
                    item.imageUrl,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                if (item.category.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.category.toUpperCase(),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 14,
                          color: Colors.black87,
                        ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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

  Widget _buildBaristaNotesBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
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
                  Text(
                    'Catatan ke Barista',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              Text(
                'Opsional',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _baristaNotesController,
            maxLines: 2,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText:
                  'Contoh: Pisahkan gula untuk latte, croissant dipanaskan sedang...',
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

  Widget _buildPaymentSummary(double subtotal, int totalCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Ringkasan Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Icon(Icons.receipt_long_outlined, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal ($totalCount Item)',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                formatRupiah(subtotal),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Pajak & Layanan (10%)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Termasuk',
                      style: TextStyle(fontSize: 9, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const Text(
                'Rp 0',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
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
                  Text(
                    'Total Pembayaran',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Sudah termasuk PB1 & servis',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                formatRupiah(subtotal),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
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
              Text(
                'Estimasi Pembuatan',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            '~ 6 - 8 Menit',
            style: TextStyle(
              fontSize: 11,
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutBtn(double subtotal) {
    return ElevatedButton(
      onPressed: widget.notifier.isLoading
          ? null
          : () async {
              final notes = _baristaNotesController.text.trim();
              final bool success = await widget.notifier.checkout(
                notes: notes,
              );
              if (!context.mounted) return;

              if (success) {
                _baristaNotesController.clear();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFFB84A0F)),
                        SizedBox(width: 8),
                        Text('Pesanan Berhasil Dibuat!'),
                      ],
                    ),
                    content: Text(
                      'Pesananmu berhasil dibuat dan tercatat di sistem.\nTotal: ${formatRupiah(subtotal)}\n\nCatatan: ${notes.isEmpty ? "-" : notes}\n\nSilakan menunggu di meja, pesananmu sedang disiapkan.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx); // Tutup pop-up
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePages(notifier: widget.notifier)),
                          );
                        },
                        child: const Text(
                          'Kembali ke Beranda',
                          style: TextStyle(
                            color: Color(0xFF4A3319),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.notifier.errorMessage ?? 'Gagal membuat pesanan',
                    ),
                  ),
                );
              }
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3319),
          borderRadius: BorderRadius.circular(16),
        ),
        child: widget.notifier.isLoading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.bolt, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Pesan Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        formatRupiah(subtotal),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
