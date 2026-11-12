import 'package:flutter/material.dart';

// Menggunakan jalur relatif agar tidak tergantung pada nama package di pubspec.yaml
import '../../domain/entities/coffee_item.dart';
import '../../domain/entities/table_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategoryIndex = 1; // Default ke "Kopi"

  final TableItem dummyTable = TableItem(
    id: 't1',
    tableNumber: 'Meja 04',
    isAvailable: false,
  );

  final List<String> categories = ['Semua', 'Kopi', 'Susu', 'Camilan', 'Manual'];

  final List<CoffeeItem> dummyMenuList = [
    CoffeeItem(
      id: 'm1',
      name: 'Espresso Romano',
      description: 'Double shot dipadukan sen...',
      price: 28000,
      imageUrl: '',
      category: 'Kopi',
      isAvailable: true,
    ),
    CoffeeItem(
      id: 'm2',
      name: 'Iced Spanish ...',
      description: 'Espresso kental, susu mani...',
      price: 35000,
      imageUrl: '',
      category: 'Kopi',
      isAvailable: true,
    ),
    CoffeeItem(
      id: 'm3',
      name: 'Cold Brew Reserve',
      description: 'Ekstraksi dingin 18 jam den...',
      price: 32000,
      imageUrl: '',
      category: 'Kopi',
      isAvailable: true,
    ),
    CoffeeItem(
      id: 'm4',
      name: 'Almond Croissant',
      description: 'Pastri renyah berlapis deng...',
      price: 34000,
      imageUrl: '',
      category: 'Camilan',
      isAvailable: true,
    ),
    CoffeeItem(
      id: 'm5',
      name: 'Oat Flat White',
      description: 'Ristretto ganda dengan mi...',
      price: 36000,
      imageUrl: '',
      category: 'Kopi',
      isAvailable: true,
    ),
  ];

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

              // 2. Table Info & Cart Badge
              _buildTableHeader(),
              const SizedBox(height: 16),

              // 3. Category Filter Scrollable
              _buildCategoryFilter(),
              const SizedBox(height: 16),

              // 4. Coffee Beans Info Banner
              _buildBeansInfoBanner(),
              const SizedBox(height: 16),

              // 5. Menu Cards List
              _buildMenuList(),
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
                Text('Menu', style: TextStyle(color: Colors.grey, fontSize: 12)),
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

  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  dummyTable.tableNumber,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Aktif',
                        style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Sesi pemesanan langsung dari barista',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        // Cart Icon with Badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.shopping_bag_outlined, color: Colors.black87, size: 22),
            ),
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3319),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: const Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4A3319) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBeansInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department_outlined, size: 16, color: Colors.brown),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Biji sangrai minggu ini: Gayo Anaero...',
              style: TextStyle(fontSize: 11, color: Colors.brown, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'Light Roast',
            style: TextStyle(fontSize: 11, color: Colors.brown[700], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dummyMenuList.length,
      itemBuilder: (context, index) {
        final item = dummyMenuList[index];
        final bool isFavorite = item.id == 'm2'; // Contoh penanda item favorit

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.06),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Gambar produk
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_cafe, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              // Detail info produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isFavorite) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDECD0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Favorit',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.brown),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${item.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              // Tombol Tambah Pesanan (+)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3319),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}