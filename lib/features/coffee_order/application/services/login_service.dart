import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/user.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future<List<User>> getUsers() async {
    try {
      final Response response = await ApiClient().get('user');
      dynamic rawData = response.data;
      if (rawData is Map<String, dynamic> && rawData.containsKey('data')) {
        rawData = rawData['data'];
      }

      if (rawData is List) {
        return rawData.map((item) => User.fromMap(item as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      print('Error getCoffee: $e');
      return [];
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final List<User> users = await getUsers();

      // for (var u in users) {
      //   print('Data DB -> Email: ${u.email}, Password: ${u.password}');
      // }
      // print('Input User -> Email: $email, Password: $password');

      // Cocokkan berdasarkan EMAIL dan PASSWORD, bukan name
      final User? matchedUser = users.cast<User?>().firstWhere(
        (user) => user?.email.trim() == email.trim() && user?.password.trim() == password.trim(),
        orElse: () => null,
      );

      if (matchedUser != null) {
        final userInfo = UserInfo();
        await userInfo.setToken(matchedUser.email);
        await userInfo.setUserID(matchedUser.id);
        await userInfo.setUsername(matchedUser.name);
        await userInfo.setMember(matchedUser.isMember.toString());
        return true;
      }
      return false;
    } catch (e) {
      print('Error login: $e');
      return false;
    }
  }
}
