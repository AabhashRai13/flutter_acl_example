import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _sharedPreferences;

  static const String email = 'email';
  static const String username = 'username';

  static const String keyIsLogin = 'isLogin';
  static const String keyUsername = 'username';

  static Future<SharedPreferencesManager> getInstance() async {
    _instance ?? SharedPreferencesManager();
 if (_instance == null) {
      _instance = SharedPreferencesManager();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    _sharedPreferences ?? await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<bool> putBool(String key, bool value) =>
      _sharedPreferences!.setBool(key, value);

  bool? getBool(String key) => _sharedPreferences!.getBool(key);

  Future<bool> putString(String key, String value) =>
      _sharedPreferences!.setString(key, value);

  String? getString(String key) => _sharedPreferences!.getString(key);

  Future<bool> clearAll() => _sharedPreferences!.clear();
}
