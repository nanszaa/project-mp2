import 'package:flutter/material.dart';
import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:coffee_shop/features/coffee_order/presentation/widgets/Menu_Item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/impl/coffee_repository_impl.dart';
import 'package:coffee_shop/features/coffee_order/domain/repositories/coffee_repository.dart';

// Impor file CartPages untuk navigasi keranjang
import 'package:coffee_shop/features/coffee_order/presentation/pages/cart_pages.dart';

class MenuScreen extends StatefulWidget {
  final CoffeeNotifier notifier;
  const MenuScreen({Key? key, required this.notifier}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Daftar filter kategori
  final List<String> _categories = [
    'Semua Menu',
    'Espresso',
    'Manual Brew',
    'Fresh Bake',
  ];

  String _selectedCategory = 'Semua Menu';

  List<CoffeeItem> _allMenuItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_onNotifierChanged);
    widget.notifier.loadMenu();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    if (!mounted) return;
    setState(() {
      _isLoading = widget.notifier.isLoading;
      _allMenuItems = widget.notifier.menuList;
    });
  }

  List<CoffeeItem> get _filteredMenuItems {
    if (_selectedCategory == 'Semua Menu') {
      return _allMenuItems;
    }
    return _allMenuItems
        .where(
          (item) =>
              item.category.toLowerCase() == _selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
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
                        child: const Icon(
                          Icons.coffee,
                          color: Color(0xFFB84A0F),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kohi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Dine-in • Meja 05',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
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
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Filter Kategori
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    final isSelected = category == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: _buildCategoryChip(category, isSelected),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Judul Menu Sesuai Kategori
              Text(
                _selectedCategory == 'Semua Menu'
                    ? 'Pilihan Menu Favorit'
                    : 'Kategori $_selectedCategory',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // [6. TAMPILAN LOADING ATAU DAFTAR KARTU MENU]
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: CircularProgressIndicator(color: Color(0xFFB84A0F)),
                  ),
                )
              else if (_filteredMenuItems.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      'Belum ada menu di kategori ini.',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                )
              else
                ..._filteredMenuItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: MenuItem(notifier: widget.notifier, item: item),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Chip Filter Kategori dengan Kursor Pointer
  Widget _buildCategoryChip(String label, bool isSelected) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFB84A0F) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}