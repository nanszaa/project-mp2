import 'package:coffee_shop/features/coffee_order/application/helpers/api_clients.dart';
import 'package:coffee_shop/features/coffee_order/application/helpers/user_info.dart';
import 'package:coffee_shop/features/coffee_order/domain/entities/user.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future<List<User>> getUsers() async {
    final Response response = await ApiClient().get('user');
    final List data = response.data as List;
    List<User> result = data.map((map) => User.fromMap(map)).toList();
    return result;
  }

  Future<bool> login(String name, String password) async {
    try {
      final List<User> users = await getUsers();

      User? matchedUser;
      for (final user in users) {
        if (user.name == name && user.password == password) {
          matchedUser = user;
          break;
        }
      }

      if (matchedUser != null) {
        await UserInfo().setToken(matchedUser.name);
        await UserInfo().setUserID(matchedUser.id.toString());
        await UserInfo().setUsername(matchedUser.name);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}