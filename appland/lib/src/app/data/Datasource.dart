// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

const endPoint = "http://192.168.0.178:7700/loginapp/api/v1";

List newPaiem = [];

List<String> contrib = [];
List<String> acteGen = [];
List<String> moisData = [];
List<String> anneeData = [];

class DataSource {
  static DataSource? _instance;
  static DataSource? get GetInstance {
    if (_instance == null) {
      return _instance = DataSource();
    } else {
      return _instance;
    }
  }

  Future<http.Response> isSave({url, body}) async {
    try {
      var response = await http.post(Uri.parse("$endPoint$url"), body: body);
      return response;
    } catch (e) {
      print(e.toString());
    }
    // ignore: null_check_always_fails
    return null!;
  }

  Future<http.Response> getData({url}) async {
    try {
      var response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {}
    // ignore: null_check_always_fails
    return null!;
  }
}
