import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/application/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/features/coffee_order/application/services/coffee_service.dart';
import 'package:coffee_shop/features/coffee_order/application/services/table_number_service.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/order.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/payment.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/table_number.dart';

class CoffeeNotifier extends ChangeNotifier {
  // INIT VARIABLE
  bool isLoading = false;
  String? errorMessage;

  String token = "";
  String userId = "";
  String username = "";
  String member = "";

  bool isSuccess = false;

  // State variable
  List<CoffeeItem> menuList = [];
  List<CoffeeItem> cart = [];
  TableNumber? activeTable;
  Order? currentOrder;
  Payment? currentPayment;

  // Helper untuk mendapatkan nomor meja aktif di UI
  String get tableNumber => activeTable?.tableNumber ?? '';

  Future<void> loadToken() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final String? savedToken = await UserInfo().getToken();
      token = savedToken ?? '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> loadUser() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final String? savedUserId = await UserInfo().getUserID();
      userId = savedUserId ?? '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUsername() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final String? savedUsername = await UserInfo().getUsername();
      username = savedUsername ?? '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> loadMember() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final String? savedMember = await UserInfo().getMember();
      member = savedMember ?? '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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
  Future<bool> checkout({
    String notes = '',
  }) async {
    final String userId = await UserInfo().getUserID() ?? '';

    // Validasi user
    if (userId.isEmpty) {
      errorMessage = 'Silahkan login terlebih dahulu';
      notifyListeners();
      return false;
    }
    // Validasi Keranjang
    if (cart.isEmpty) {
      errorMessage = 'Keranjang belanja masih kosong.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final Order order = Order(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        tableId: activeTable?.id,
        items: List.from(cart),
        totalPrice: totalPrice,
        orderStatus: 'Pending',
        notes: notes,
      );

      await OrderService().create(order);

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
  // Future<bool> processPayment(String method) async {
  //   if (currentOrder == null) {
  //     errorMessage = 'Tidak ada pesanan aktif untuk dibayar.';
  //     notifyListeners();
  //     return false;
  //   }

  //   isLoading = true;
  //   errorMessage = null;
  //   notifyListeners();

  //   try {
  //     final payment = Payment(
  //       id: 'PAY-${DateTime.now().millisecondsSinceEpoch}',
  //       orderId: currentOrder!.id,
  //       amount: currentOrder!.totalPrice,
  //       method: method,
  //       status: 'Pending',
  //       paymentDate: DateTime.now(),
  //     );

  //     currentPayment = await processPaymentUseCase.execute(payment);
  //     isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }
}