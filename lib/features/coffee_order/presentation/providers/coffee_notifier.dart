import 'package:flutter/material.dart';
import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/application/services/table_number_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/create_order_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/get_menu_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/process_payment_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/scan_table_use_case.dart';

class CoffeeNotifier extends ChangeNotifier {
  final GetMenuUseCase getMenuUseCase;
  final ScanTableUseCase scanTableUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;

  CoffeeNotifier({
    required this.getMenuUseCase,
    required this.scanTableUseCase,
    required this.createOrderUseCase,
    required this.processPaymentUseCase,
  });

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  // State variable
  List<CoffeeItem> menuList = [];
  List<CoffeeItem> cart = [];
  TableNumber? activeTable;
  Order? currentOrder;
  Payment? currentPayment;

  // Helper untuk mendapatkan nomor meja aktif di UI
  String get tableNumber => activeTable?.tableNumber ?? '';

  // Kelola Cart
  void addToCart(CoffeeItem item) {
    cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CoffeeItem item) {
    cart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  double get totalPrice {
    return cart.fold(0, (sum, item) => sum + item.price);
  }

  // Ambil Menu
  Future<void> loadMenu() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      menuList = await CoffeeService().getCoffee();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Scan / Ambil Data Meja
  Future<void> scanTable(String? rawScanValue) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    if (rawScanValue == null || rawScanValue.trim().isEmpty) {
      isLoading = false;
      errorMessage = 'QR code tidak sesuai.';
      notifyListeners();
      return;
    }

    try {
      final String tableId = _extractTableId(rawScanValue.trim());
      activeTable = await TableNumberService().getTableById(tableId);
    } catch (e) {
      errorMessage = 'Format QR meja tidak valid.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String _extractTableId(String rawValue) {
    final uri = Uri.tryParse(rawValue);
    if (uri != null && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return rawValue;
  }

  // Checkout Pesanan
  Future<bool> checkoutOrder({
    required String userId,
    String notes = '',
  }) async {
    // 1. Validasi Meja
    if (activeTable == null) {
      errorMessage = 'Silakan pilih atau scan meja terlebih dahulu.';
      notifyListeners();
      return false;
    }

    // 2. Validasi Keranjang
    if (cart.isEmpty) {
      errorMessage = 'Keranjang belanja masih kosong.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final newOrder = Order(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        tableId: activeTable!.id,
        items: List.from(cart),
        totalPrice: totalPrice,
        orderStatus: 'Pending',
        notes: notes,
      );

      currentOrder = await createOrderUseCase.execute(newOrder);

      // Bersihkan keranjang saat order sudah tercatat
      cart.clear();

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Proses Pembayaran
  Future<bool> processPayment(String method) async {
    if (currentOrder == null) {
      errorMessage = 'Tidak ada pesanan aktif untuk dibayar.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final payment = Payment(
        id: 'PAY-${DateTime.now().millisecondsSinceEpoch}',
        orderId: currentOrder!.id,
        amount: currentOrder!.totalPrice,
        method: method,
        status: 'Pending',
        paymentDate: DateTime.now(),
      );

      currentPayment = await processPaymentUseCase.execute(payment);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}