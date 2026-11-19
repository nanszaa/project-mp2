import 'package:intl/intl.dart';

String formatRupiah(num nominal) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',    // Format lokal Indonesia (pemisah ribuan memakai titik)
    symbol: 'Rp ',       // Simbol mata uang
    decimalDigits: 0,    // Jumlah angka di belakang koma (0 = tanpa desimal)
  );

  return formatter.format(nominal);
}