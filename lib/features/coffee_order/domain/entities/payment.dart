class Payment {
  final String id;
  final String orderId;
  final double amount;
  final String method;
  final String status;
  final DateTime paymentDate;

  Payment({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    required this.status,
    required this.paymentDate,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map["id"]?.toString() ?? '',
      orderId: map["orderId"]?.toString() ?? '',
      amount: (map["amount"] as num?)?.toDouble() ?? 0.0,
      method: map["method"]?.toString() ?? '',
      status: map["status"]?.toString() ?? '',
      paymentDate: map["paymentDate"] != null
          ? DateTime.parse(map["paymentDate"].toString())
          : DateTime.now(),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json) => Payment.fromMap(json);

  Map<String, dynamic> toMap() => {
    'id': id,
    'orderId': orderId,
    'amount': amount,
    'method': method,
    'status': status,
  'paymentDate': paymentDate,
  };

  Map<String, dynamic> toJson() => toMap();
}
