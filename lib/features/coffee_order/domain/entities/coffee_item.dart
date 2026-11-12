class CoffeeItem {
  String id;
  String name;
  String description;
  int price;
  String imageUrl;
  String category;
  bool isAvailable;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
  });
}