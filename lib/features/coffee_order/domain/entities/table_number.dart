class TableNumber {
  final String id;
  final String tableNumber;
  final bool isAvailable;

  TableNumber({
    required this.id,
    required this.tableNumber,
    required this.isAvailable,
  });

  factory TableNumber.fromMap(Map<String, dynamic> map) {
    return TableNumber(
      id: map["id"]?.toString() ?? '',
      tableNumber: map["table_number"]?.toString() ?? '',
      isAvailable: map["is_available"] ?? false,
    );
  }

  factory TableNumber.fromJson(Map<String, dynamic> json) =>
      TableNumber.fromJson(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'table_number': tableNumber,
    'is_available': isAvailable,
  };

  Map<String, dynamic> toJson() => toMap();
}
