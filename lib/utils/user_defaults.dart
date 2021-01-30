

import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {

  static Future<String> get username async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 
    return sharedPreferences.get("username"); 
  }

}