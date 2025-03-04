import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferencesAsync _asyncPrefs;


  LocalStorage() {
    _asyncPrefs = SharedPreferencesAsync();
  }

  // escritura al shared preferences
  Future<void> setLoginStatus(bool logiStatus) async {
    await _asyncPrefs.setBool("isAuthenticated", logiStatus);
  }

  Future<void> setUser(String user) async {
    await _asyncPrefs.setString("user", user);
  }

  Future<void> clearAll() async {
    await _asyncPrefs.clear();
  }

  // lectura de valores
  Future<bool> getLoginStatus() async => await _asyncPrefs.getBool("isAuthenticated") ?? false;
  Future<String> getUser() async => await _asyncPrefs.getString("user") ?? '';

}
