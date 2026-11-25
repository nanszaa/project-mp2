import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/application/services/order_service.dart';
import 'package:coffee_shop/features/coffee_order/application/services/table_number_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/create_order_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/get_menu_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/process_payment_use_case.dart';
import 'package:coffee_shop/features/coffee_order/domain/usecases/scan_table_use_case.dart';
import 'package:flutter/material.dart';

class CoffeeNotifier extends ChangeNotifier {
  final OrderService orderService;

  final GetMenuUseCase getMenuUseCase;
  final ScanTableUseCase scanTableUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;

  CoffeeNotifier({
    required this.orderService,
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

  Future<void> createOrder({
    required String userId,
    required String tableId,
    required List<CoffeeItem> items,
    required double totalPrice,
    required String orderStatus,
    Payment? payment,
  }) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();

    final success = await orderService.createOrder(
      userId: userId,
      tableId: tableId,
      items: items,
      totalPrice: totalPrice,
      orderStatus: orderStatus,
      payment: payment,
    );

    isLoading = false;
    if (success) {
      isSuccess = true;
    } else {
      errorMessage = 'Gagal membuat pesanan. Silahkan coba lagi.';
    }
    notifyListeners();
  }

  Future<void> scanTable(String? rawScanValue) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    
    if (rawScanValue == null || rawScanValue.trim().isEmpty) {
      throw Exception('QR code tidak sesuai.');
    }

    try {
      final String tableId = _extractTableId(rawScanValue.trim());
      activeTable = await TableNumberService().getTableById(tableId);
    } catch (e) {
      throw Exception('Format QR meja tidak Valid.');
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

  // ambil menu
  Future<void> loadMenu() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      menuList = await CoffeeService().getCoffee();
      print(
        'Menu loaded: ${menuList.length} items',
      ); // Debugging: tampilkan jumlah item menu yang berhasil dimuat
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // kelola cart
  void addToCart(CoffeeItem item) {
    cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CoffeeItem item) {
    cart.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    return cart.fold(0, (sum, item) => sum + item.price);
  }

  // buat pesanan
  Future<bool> checkoutOrder(String userId) async {
    if (activeTable == null || cart.isEmpty) return false;

    isLoading = true;
    notifyListeners();

    try {
      final newOrder = Order(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        tableId: activeTable!.id,
        items: List.from(cart),
        totalPrice: totalPrice,
        orderStatus: 'Pending',
      );

      currentOrder = await createOrderUseCase.execute(newOrder);
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

  // proses pembayaran
  Future<bool> processPayment(String method) async {
    if (currentOrder == null) return false;

    isLoading = true;
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
}
