import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';

class LocalDb {
  static final String _userdbData = "userDb";
  static final String _tokenDbData = "tokenDb";

  /// set datas
  static Future<void> saveToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenDbData, token);
  }

  static Future<void> saveUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await pref.setString(_userdbData, jsonString);
  }

  /// get datas
  static Future<String?> getSavedToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = pref.getString(_tokenDbData);
    return res;
  }

  static Future<User?> getSavedUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString(_userdbData);
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return User.fromJson(jsonMap);
  }

  static Future<void> clearAll() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}

