// lib/infrastructure/datasources/coffee_api_service.dart
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:dio/dio.dart';

class CoffeeService {
  final Dio _dio;

  CoffeeService() : _dio = Dio(BaseOptions(
    baseUrl: 'https://api.dosen.com/api/', // Ganti dengan Base URL dari dosen
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Jika butuh token bearer (auth), tambahkan di sini:
      // 'Authorization': 'Bearer YOUR_TOKEN',
    },
  ));

  // Method untuk mengambil data menu kopi dari API
  Future<List<CoffeeItem>> fetchCoffeeMenu() async {
    try {
      final response = await _dio.get('coffee-menu'); // Endpoint spesifik menu

      // Periksa apakah response berhasil (biasanya status code 200)
      if (response.statusCode == 200) {
        // Asumsi data dari dosen berupa List JSON di dalam key 'data' atau langsung berupa List
        final List data = response.data['data'] ?? response.data;

        // Mapping dari JSON ke Entity CoffeeItem
        return data.map((json) => CoffeeItem(
          id: json['id'].toString(),
          name: json['name'] ?? '',
          description: json['description'] ?? '',
          price: (json['price'] as num).toDouble(),
          imageUrl: json['image_url'] ?? '',
          category: json['category'] ?? '',
          isAvailable: json['is_available'] ?? true,
        )).toList();
      } else {
        throw Exception('Gagal memuat menu: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Tangani error khusus Dio (misal: timeout, no internet, 404, 500)
      throw Exception('Kesalahan jaringan: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}