import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test/model/user_model.dart';

class LocalStorage {
  static String user = 'user';
  static SharedPreferences ?_sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  static UserModel userData(){
    return UserModel.fromJson(jsonDecode(_sharedPreferences?.getString(user) ?? ''));
  }
  static setUserData(UserModel userModel){
    _sharedPreferences?.setString(user, jsonEncode(userModel.toJson()));
  }

  static bool userExist() {
    return _sharedPreferences?.containsKey(user) ?? false;
  }

  static setString(String key, String value) async {
     _sharedPreferences?.setString(key, value);
  }

  static String getString(String key) {
    return _sharedPreferences?.getString(key) ?? '';
  }

  static clear() {
    _sharedPreferences?.clear();
  }

}