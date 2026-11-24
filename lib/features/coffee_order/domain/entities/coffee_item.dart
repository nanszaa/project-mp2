class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
  });

  factory CoffeeItem.fromMap(Map<String, dynamic> map) {
    return CoffeeItem(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? map['image_url'] ?? '',
      category: map['category'] ?? '',
      isAvailable: map['isAvailable'] ?? map['is_available'] ?? true,
    );
  }

  factory CoffeeItem.fromJson(Map<String, dynamic> json) =>
      CoffeeItem.fromMap(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'category': category,
    'isAvailable': isAvailable,
  };

  Map<String, dynamic> toJson() => toMap();
}