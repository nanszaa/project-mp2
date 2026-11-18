// lib/infrastructure/datasources/coffee_api_service.dart
import 'package:coffee_shop/features/coffee_order/domain/entities/coffee_item.dart';
import 'package:dio/dio.dart';

class CoffeeService {
  final Dio _dio;

  CoffeeService(): _dio = Dio(BaseOptions(
      baseUrl: 'https://apilearn.kaylabs.id/api/v1/p-ptwsvxh5/',
      headers: {
        'Accept': 'application/json',
        'X-API-KEY': 'apl_Nk6iMVrp56SpsE6ZUpdItSb7IvvJeIdW',
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  // Method untuk mengambil data menu kopi dari API
  Future<List<CoffeeItem>> fetchCoffeeMenu() async {
    try {
      final response = await _dio.get('coffee-item'); // Endpoint spesifik menu
      
      // Periksa apakah response berhasil (biasanya status code 200)
      if (response.statusCode == 200) {
        // Asumsi data dari dosen berupa List JSON di dalam key 'data' atau langsung berupa List
        final List data = response.data["data"] ?? response.data;

        // Mapping dari JSON ke Entity CoffeeItem
        return data
            .map(
              (json) => CoffeeItem(
                id: json["id"].toString(),
                name: json["name"] ?? '',
                description: json["description"] ?? '',
                price: (json["price"] as num).toDouble(),
                imageUrl: json["image_url"] ?? '',
                category: json["category"] ?? '',
                isAvailable: json["isAvailable"] ?? true,
              ),
            )
            .toList();
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
