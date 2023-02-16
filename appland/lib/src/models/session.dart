import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static MyPreferences _myPreferences = new MyPreferences();

  static String userId = '';

  static MyPreferences get getInit {
    return _myPreferences;
  }

  Future<bool> setPersistence(var data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('Fk_idagent', data[0]['Fk_idagent']);
  }

  Future<void> getPersistence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('Fk_idagent').toString();
  }
}
