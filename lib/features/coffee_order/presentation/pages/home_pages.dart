import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/menu_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/pages/scanner_pages.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  final CoffeeNotifier notifier;
  final String? token;
  final String? userId;
  final String? username;
  final String? member;

  const HomePages({
    super.key,
    required this.notifier,
    required this.token,
    required this.userId,
    required this.username,
    required this.member,
  });

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedNavIndex = 0;
  List<CoffeeItem> _allMenuItems = [];

  String? _token;
  String? _userId;
  String? _username;
  String? _member;

 @override
  void initState() {
    super.initState();

    widget.notifier.addListener(_onNotifierChanged);
    widget.notifier.loadMenu();

    _token = widget.token;
    _userId = widget.userId;
    _username = widget.username;
    _member = widget.member;

    // Ambil data terbaru dari UserInfo secara otomatis saat halaman dibuka
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final token = await UserInfo().getToken();
    final userId = await UserInfo().getUserID();
    final username = await UserInfo().getUsername();

    if (mounted) {
      setState(() {
        _token = token ?? widget.token;
        _userId = userId ?? widget.userId;
        _username = username ?? widget.username;
      });
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    if (!mounted) return;
    setState(() {
      _allMenuItems = widget.notifier.menuList;
    });
  }

  void _onScanQrPressed() {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login terlebih dahulu untuk scan QR meja.'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerPages(notifier: widget.notifier),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0), // Latar belakang krem hangat
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header
              _buildTopHeader(_username),
              const SizedBox(height: 20),
              // 2. Greeting & Unscanned Badge
              _buildGreetingSection(_token, _username),
              const SizedBox(height: 16),
              // 3. Scan QR Banner Card (Primary Action)
              _buildScanQrBanner(_token),
              const SizedBox(height: 20),
              // 4. Chef's Table Perks Promo
              _buildMemberPromoCard(_token),
              const SizedBox(height: 20),
              // 5. Menu List
              _buildMenuList(),
              const SizedBox(height: 20),
              // 6. Waiter Assistance Card
              _buildWaiterAssistanceCard(),
            ],
          ),
        ),
      ),
      // 7. Bottom Navigation Bar dengan Tombol Tengah (Scan QR)
      bottomNavigationBar: _buildBottomNavBar(_selectedNavIndex),
    );
  }

  Widget _buildTopHeader(String? username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.coffee, color: Color(0xFF4E342E), size: 28),
            SizedBox(width: 8),
            Text(
              'KopiKita',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {
            // Arahkan ke halaman Login atau Profil
          },
          icon: Icon(
            _token != null ? Icons.person : Icons.login,
            size: 18,
            color: const Color(0xFF4E342E),
          ),
          label: Text(
            _token != null ? (username ?? 'Member') : 'Login',
            style: const TextStyle(
              color: Color(0xFF4E342E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingSection(String? token, String? username) {
    final bool hasTable = widget.notifier.activeTable != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                token != null && username != null
                    ? 'Halo, $username!'
                    : 'Selamat Datang!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Scan QR di meja untuk pesan & diantar langsung.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: hasTable ? const Color(0xFFE6F4EA) : const Color(0xFFFFF3CD),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                hasTable ? Icons.check_circle : Icons.table_restaurant,
                size: 14,
                color: hasTable ? Colors.green[800] : Colors.amber[900],
              ),
              const SizedBox(width: 6),
              Text(
                hasTable ? widget.notifier.activeTable!.id : 'Belum Scan Meja',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanQrBanner(String? token) {
    final bool hasTable = widget.notifier.activeTable != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4E342E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hasTable
                ? 'Terhubung ke Meja ${widget.notifier.activeTable!.tableNumber}'
                : 'Pesan dari Meja via Scan QR',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            token != null
                ? 'Arahkan kamera ke QR code pada meja kosong, pilih menu, lalu bayar.'
                : 'Login dulu ke aplikasi, lalu scan QR meja agar pesanan langsung diantar ke mejamu.',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _onScanQrPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD7CCC8),
              foregroundColor: const Color(0xFF3E2723),
            ),
            icon: const Icon(Icons.qr_code_scanner),
            label: Text(hasTable ? 'Ganti / Scan Ulang QR' : 'Scan QR Meja'),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberPromoCard(String? token) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6DFD3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Color(0xFF8D6E63), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  token != null
                      ? 'Promo Khusus Member Aktif'
                      : 'Info Promo Member',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Member dapat menikmati promo spesial, termasuk saat transaksi lewat kasir atau web.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    final allMenus = widget.notifier.menuList;
    final previewMenus = allMenus.take(10).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jelajahi Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            OutlinedButton(
              onPressed: () {
                // Navigasi ke halaman daftar menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(
                      notifier: widget.notifier,
                      token: widget.token,
                      userId: widget.userId,
                      username: widget.username,
                      member: widget.member,
                    ),
                  ),
                );
              },
              child: const Text('Lihat Menu'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // list 10 menu carousel
        previewMenus.isEmpty
            ? Text(
                'Belum ada menu tersedia.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            : SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: previewMenus.length,
                  itemBuilder: (context, index) {
                    final item = previewMenus[index];
                    return _buildMenuCarouselCard(item);
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildMenuCarouselCard(dynamic item) {
    // Ganti tipe `dynamic` menjadi `CoffeeItem` sesuai model menu kamu
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6DFD3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: item.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14), 
                      topRight: Radius.circular(14)
                    ),
                    child: Image.network(
                      item.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey[200],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.coffee, color: Colors.grey),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[200],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.coffee, color: Colors.grey),
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${item.price}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB84A0F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaiterAssistanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EFE6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.room_service, color: Color(0xFF5D4037)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.notifier.activeTable != null
                  ? 'Setelah pembayaran berhasil, barista menyiapkan pesanan dan waiter/kasir akan mengantarnya ke Meja ${widget.notifier.activeTable!.tableNumber}.'
                  : 'Pesanan QR akan langsung diantar waiter/kasir ke meja setelah selesai dibuat. Butuh bantuan? Hubungi kasir atau waiter.',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF4E342E),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 1) {
          _onScanQrPressed();
          return;
        }
        setState(() {
          _selectedNavIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Pesanan',
        ),
      ],
    );
  }
}
