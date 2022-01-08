import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> isRemember() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool remember = preferences.getBool("remember") ?? false;
    print('Remember: $remember');
    return remember;
  }
}
