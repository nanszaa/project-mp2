class TableNumber {
  final String id;
  final String tableNumber;
  final bool isOccupied;

  TableNumber({
    required this.id,
    required this.tableNumber,
    required this.isOccupied,
  });

  factory TableNumber.fromMap(Map<String, dynamic> map) {
    return TableNumber(
      id: map["id"]?.toString() ?? '',
      tableNumber: map["tableNumber"]?.toString() ?? '',
      isOccupied: map["isOccupied"] ?? false,
    );
  }

  factory TableNumber.fromJson(Map<String, dynamic> json) =>
      TableNumber.fromJson(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'tableNumber': tableNumber,
    'isOccupied': isOccupied,
  };

  Map<String, dynamic> toJson() => toMap();
}
