import 'package:shared_preferences/shared_preferences.dart';

class AppLocalData {
  Future<void> setStringPrefValue(
      {required String key, required String value}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<String?> getStringPrefValue({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> containsKey({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}

class SharedPrefConstants {
  static const String memesResponse = 'memesResponse';
}
