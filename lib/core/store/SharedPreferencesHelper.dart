import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key , String value) async {
    await prefs?.setString(key, value);
  }

  static String? getString(String key){
    return prefs?.getString(key);
  }

  static Future<void> setBool(String key , bool value) async {
    await prefs?.setBool(key, value);
  }

  static bool? getBool(String key){
    return prefs?.getBool(key);
  }

  static Future<void> setInt(String key , int value) async {
    await prefs?.setInt(key, value);
  }

  static int? getInt(String key){
    return prefs?.getInt(key);
  }

    static Future<void> setDouble(String key, double value) async {
    await prefs?.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return prefs?.getDouble(key);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await prefs?.setStringList(key, value);
  }

  static List<String>? getStringList(String key){
    return prefs?.getStringList(key);
  }

  static Future<void> remove(String key) async {
    await prefs?.remove(key);
  }

  static Future<void> clear () async {
    await prefs?.clear();
  }
}


// await SharedPreferencesManager.setString("username", "ahmad");
// await SharedPreferencesManager.setDouble("balance", 2500.50);
// await SharedPreferencesManager.setStringList("tags", ["flutter", "firebase", "backend"]);

// String? username = SharedPreferencesManager.getString("username");
// double? balance = SharedPreferencesManager.getDouble("balance");
// List<String>? tags = SharedPreferencesManager.getStringList("tags");
