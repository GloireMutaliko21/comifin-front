import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static MyPreferences _myPreferences = new MyPreferences();

  static String userId = '';

  static MyPreferences get getInit {
    return _myPreferences;
  }

  Future<bool> setPersistence(var data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('id', data['id']);
  }

  Future<void> getPersistence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id').toString();
  }
}
