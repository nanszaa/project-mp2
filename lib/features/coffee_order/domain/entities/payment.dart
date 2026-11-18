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
}