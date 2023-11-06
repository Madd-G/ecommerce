import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/auth_response_model.dart';

class AuthLocalDatasource {
  //save auth data
  Future<void> saveAuthData(AuthResponseModel model) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth', model.toJson());
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth');
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.jwt ?? '';
  }

  Future<User> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.user!;
  }

  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }
}
