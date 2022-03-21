import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<bool> assignAccessToken(String accessToken) async {
    if (accessToken != "") {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString('accessToken', accessToken);
    }
    return false;
  }

  static Future<String?> get accessToken async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) {
      return null;
    }
    return prefs.getString('accessToken');
  }

  static Future<bool> flushToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('accessToken');
  }

  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
  }
}
