import 'package:flutter/material.dart';

class ProfilePages extends StatelessWidget {
  const ProfilePages({super.key});

  @override
  Widget build(BuildContext context) {
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

              // 2. User Profile Card Info
              _buildUserProfileHeader(),
              const SizedBox(height: 16),

              // 3. Kohi Fellowship Membership Card
              _buildMembershipCard(),
              const SizedBox(height: 16),

              // 4. Three Shortcut Cards (Riwayat, Voucher, Metode Bayar)
              _buildShortcutCards(),
              const SizedBox(height: 16),

              // 5. Default Coffee Recipe Preferences
              _buildDefaultRecipeSection(),
              const SizedBox(height: 16),

              // 6. Settings & Support List
              _buildSettingsSection(context),
              const SizedBox(height: 20),

              // 7. Logout Button
              _buildLogoutButton(),
              const SizedBox(height: 16),

              // 8. App Version Footer
              _buildAppVersionFooter(),
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
                Text('Meja 04 • Dine-in', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
              child: const Icon(Icons.search, size: 20, color: Colors.black87),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
              child: const Icon(Icons.notifications_none, size: 20, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserProfileHeader() {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: const Icon(Icons.person, size: 35, color: Colors.grey),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Sarah Amanda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDECD0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Gold',
                      style: TextStyle(color: Colors.brown, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                'sarah.amanda@email.com',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Terkoneksi Meja 04 • Dine-in',
                    style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: const Icon(Icons.edit_outlined, size: 18, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF322216), // Cokelat sangat gelap / hampir hitam
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KOHI FELLOWSHIP',
                    style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Kohi Gold Member',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Icon(Icons.card_membership, color: Colors.white30, size: 36),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Total Saldo Poin', style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text('350', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Text('Kohi Pts', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Progress ke Platinum', style: TextStyle(color: Colors.white70, fontSize: 11)),
              Text('350 / 500 Pts', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: 350 / 500,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFDECD0)),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tersisa 150 poin lagi untuk nikmati complimentary pour-over bulanan.',
            style: TextStyle(color: Colors.white60, fontSize: 11),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ID: KH-8849-GLD',
                style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.local_offer_outlined, size: 14, color: Colors.brown),
                label: const Text('Tukar Poin', style: TextStyle(color: Colors.brown, fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDECD0),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutCards() {
    return Row(
      children: [
        Expanded(child: _shortcutItem(Icons.receipt_long, 'Riwayat Pesanan', '14 Order')),
        const SizedBox(width: 8),
        Expanded(child: _shortcutItem(Icons.local_activity_outlined, 'Voucher Saya', '3 Aktif', hasBadge: true)),
        const SizedBox(width: 8),
        Expanded(child: _shortcutItem(Icons.account_balance_wallet_outlined, 'Metode Bayar', 'QRIS / GoPay')),
      ],
    );
  }

  Widget _shortcutItem(IconData icon, String title, String subtitle, {bool hasBadge = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: const Color(0xFF4A3319)),
              if (hasBadge)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF4A3319), shape: BoxShape.circle),
                  child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildDefaultRecipeSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.tune, size: 16, color: Colors.black87),
                  SizedBox(width: 6),
                  Text('Racikan Default Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
              Text('Atur', style: TextStyle(color: Colors.brown, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Kohi Barista akan otomatis merekomendasikan takaran favoritmu saat order:',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _recipeChip('☕ Oat Milk (Oatside)'),
              _recipeChip('💧 Less Sugar (50%)'),
              _recipeChip('❄️ Normal Ice'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recipeChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'PENGATURAN & BANTUAN',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
            ),
          ),
          _settingItem(Icons.location_on_outlined, 'Alamat & Meja Tersimpan', 'Kohi Senopati • Meja 04 Favorit'),
          _settingItem(Icons.receipt_outlined, 'Riwayat Transaksi & Struk Digital', 'Unduh e-receipt dan pajak pesanan'),
          _settingItem(Icons.headset_mic_outlined, 'Pusat Bantuan Barista & FAQ', 'Tanya seputar seduhan atau kendala akun'),
          _settingItem(Icons.lock_outline, 'Keamanan Akun & Notifikasi', 'Biometrik, PIN Transaksi & Promo', showDivider: false),
        ],
      ),
    );
  }

  Widget _settingItem(IconData icon, String title, String subtitle, {bool showDivider = true}) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: Colors.black87),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: () {},
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFF2F2F2), indent: 60, endIndent: 16),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout, size: 18, color: Colors.redAccent),
          SizedBox(width: 8),
          Text(
            'Keluar dari Akun',
            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAppVersionFooter() {
    return Center(
      child: const Text(
        'Kohi Coffee App v2.4.0 (104) • Dibuat dengan cinta untuk penikmat kopi',
        style: TextStyle(color: Colors.grey, fontSize: 10),
        textAlign: TextAlign.center,
      ),
    );
  }
}