import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

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
              _buildTopHeader(),
              const SizedBox(height: 20),

              // 2. Greeting & Unscanned Badge
              _buildGreetingSection(),
              const SizedBox(height: 16),

              // 3. Scan QR Banner Card (Primary Action)
              _buildScanQrBanner(),
              const SizedBox(height: 20),

              // 4. Chef's Table Perks Promo
              _buildChefPerksSection(),
              const SizedBox(height: 20),

              // 5. Locked Menu Box
              _buildLockedMenuCard(),
              const SizedBox(height: 20),

              // 6. Waiter Assistance Card
              _buildWaiterAssistanceCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // 7. Bottom Navigation Bar dengan Tombol Tengah (Scan QR)
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant, color: Color(0xFFB84A0F), size: 20),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DINE-IN BISTRO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Home Screen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
              child: const Icon(Icons.notifications_none, size: 20, color: Colors.black87),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFB84A0F)),
              child: const Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello, Foodie! 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              'Ready to enjoy fresh culinary delights?',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFECE6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              const Text('Belum Scan Meja', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanQrBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFFDECD0), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.qr_code, color: Color(0xFFB84A0F), size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'LANGKAH PERTAMA',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFB84A0F), letterSpacing: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Scan QR Meja untuk Membuka Menu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          const Text(
            'Arahkan kamera ke kode QR di meja Anda untuk mengaktifkan pemesanan & melihat menu spesial.',
            style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB84A0F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt_outlined, size: 18),
                  SizedBox(width: 8),
                  Text('Scan QR Meja Sekarang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF7F5F0),
                foregroundColor: Colors.black87,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, size: 16, color: Color(0xFFB84A0F)),
                  SizedBox(width: 6),
                  Text('Simulasikan Scan QR Meja (Demo)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.lock_open, size: 12, color: Colors.green),
                SizedBox(width: 4),
                Text('Menu otomatis terbuka seketika setelah scan', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChefPerksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Icon(Icons.local_offer_outlined, size: 16, color: Color(0xFFB84A0F)),
                SizedBox(width: 6),
                Text("Chef's Table Perks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            Text('Swipe deals →', style: TextStyle(fontSize: 12, color: Color(0xFFB84A0F), fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.brown[900],
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1544025162-d76694265947?w=500'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.orange[800], borderRadius: BorderRadius.circular(8)),
                child: const Text('25% OFF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("CHEF'S CUT SPECIAL", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                  const Text('A5 Wagyu Ribeye Steak', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Use at checkout: CHEF25', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          minimumSize: const Size(0, 28),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('COPY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLockedMenuCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFFFDECD0), shape: BoxShape.circle),
            child: const Icon(Icons.lock_outline, color: Color(0xFFB84A0F), size: 24),
          ),
          const SizedBox(height: 12),
          const Text(
            'Menu akan tampil setelah di scan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          const Text(
            'Silakan scan QR code di meja restoran Anda untuk membuka daftar menu lengkap, harga, dan melakukan pemesanan langsung dari meja.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB84A0F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.qr_code_scanner, size: 18),
                  SizedBox(width: 8),
                  Text('Buka Kunci Menu (Scan QR)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaiterAssistanceCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFECE6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.room_service, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Need waiter assistance?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 2),
                Text('Tap to alert your assigned floor server', style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Call Waiter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Tab Home (Aktif)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.restaurant_menu, color: Color(0xFFB84A0F), size: 22),
              SizedBox(height: 2),
              Text('Home', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFB84A0F))),
            ],
          ),
          // Tab Tengah (Scan QR Terhighlight Bulat)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFB84A0F),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 22),
          ),
          // Tab Profile
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.person_outline, color: Colors.grey, size: 22),
              SizedBox(height: 2),
              Text('Profile', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}