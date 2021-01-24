

import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {

  Future<bool> login(String username) async {
    final userDefault = await SharedPreferences.getInstance(); 
    // save username in user shared preferences 
    return userDefault.setString("username", username);
  }

}