import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: 'https://apilearn.kaylabs.id/api/v1/p-ptwsvxh5/',
  connectTimeout: Duration(milliseconds: 5000),
  receiveTimeout: Duration(milliseconds: 3000),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-API-KEY': 'apl_Nk6iMVrp56SpsE6ZUpdItSb7IvvJeIdW'
  }
  ));

class ApiClient {
  Future<Response> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } on DioException catch (e) {
      // Dio versi modern menggunakan DioException (versi lama: DioError)
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(path);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  Future<Response> patch(String path, dynamic data) async {
    try {
      final response = await dio.patch(path, data: data);
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
  
}