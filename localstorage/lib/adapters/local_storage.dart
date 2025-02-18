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

  // lectura de valores
  Future<bool> getLoginStatus() async => await _asyncPrefs.getBool("isAuthenticated") ?? false;

}
