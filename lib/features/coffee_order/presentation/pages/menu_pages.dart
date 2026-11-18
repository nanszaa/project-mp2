import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
              // Header Atas Menu
              Row(
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
                        child: const Icon(Icons.coffee, color: Color(0xFFB84A0F), size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kohi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Dine-in • Meja 04', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                        child: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Kategori Filter (Pilihan Barista, Espresso Bar, Fresh Bake, dll)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('Semua Menu', true),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Espresso Bar', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Manual Brew', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Fresh Bake', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Daftar Produk / Menu Makanan & Minuman
              const Text(
                'Pilihan Favorit Di Meja 04',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              _buildMenuItemCard(
                title: 'Iced Spanish Latte',
                category: 'ESPRESSO BAR',
                description: 'Espresso ganda, susu segar, dan krimer kental manis.',
                price: 'Rp 35.000',
              ),
              const SizedBox(height: 12),
              _buildMenuItemCard(
                title: 'Almond Croissant',
                category: 'FRESH BAKE',
                description: 'Mentega Prancis AOP dengan taburan kacang almond renyah.',
                price: 'Rp 30.000',
              ),
              const SizedBox(height: 12),
              _buildMenuItemCard(
                title: 'Single Origin Toraja',
                category: 'MANUAL BREW',
                description: 'Metode V60 dengan notes fruity dan acidity seimbang.',
                price: 'Rp 38.000',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFB84A0F) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildMenuItemCard({
    required String title,
    required String category,
    required String description,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
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
                Text(
                  category,
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFDECD0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 18, color: Color(0xFFB84A0F)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}