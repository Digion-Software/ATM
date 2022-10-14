import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<SharedPreferences> _getPreference() async {
    return await SharedPreferences.getInstance();
  }

  static void setString({required String key, required String value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    sharedPreferences.setString(key, value);
  }

  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getString(key);
  }

  static void setBool({required String key, required bool value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getBool(key);
  }

  static void setDouble({required String key, required double value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    sharedPreferences.setDouble(key, value);
  }

  static Future<int?> getInteger({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getInt(key);
  }

  static void setInteger({required String key, required int value}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    sharedPreferences.setInt(key, value);
  }

  static Future<double?> getDouble({required String key}) async {
    SharedPreferences sharedPreferences = await _getPreference();
    return sharedPreferences.getDouble(key);
  }

  static Future<bool> clearStorage() async {
    SharedPreferences sharedPreferences = await _getPreference();
    return await sharedPreferences.clear();
  }
}
