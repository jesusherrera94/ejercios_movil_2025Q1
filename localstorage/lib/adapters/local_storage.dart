import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  late SharedPreferencesAsync asyncPrefs;

  LocalStorage() {
   asyncPrefs = SharedPreferencesAsync();
  }

  Future<void> setLoginStatus(bool loginStatus) async {
    await asyncPrefs.setBool("loginStatus", loginStatus);
  }

  Future<bool> getLoginStatus() async => await asyncPrefs.getBool("loginStatus") ?? false;

}