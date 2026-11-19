import 'package:coffee_shop/features/coffee_order/presentation/providers/coffee_notifier.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';

class MenuItem extends StatefulWidget {
  final CoffeeNotifier notifier;
  final CoffeeItem item;
  
  const MenuItem({
    super.key, 
    required this.notifier, 
    required this.item
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
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
          // Gambar menu produk
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: widget.item.imageUrl.isNotEmpty
                ? Image.network(
                    widget.item.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[200],
                      child: const Icon(Icons.coffee, color: Colors.grey),
                    ),
                  )
                : Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[200],
                    child: const Icon(Icons.coffee, color: Colors.grey),
                  ),
          ),
          const SizedBox(width: 12),
          // Rincian teks menu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.item.description,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Rp ${widget.item.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Tombol tambah ke keranjang
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFDECD0),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 18, color: Color(0xFFB84A0F)),
              onPressed: () {
                widget.notifier.addToCart(widget.item);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.item.name} ditambahkan ke keranjang.'),
                    duration: const Duration(milliseconds: 800),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}