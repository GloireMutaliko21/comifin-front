// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names
import 'dart:convert';
import 'dart:ffi';

import 'package:app/src/models/contribution.dart';
import 'package:http/http.dart' as http;

const endPoint = "https://comifin.saetech.site/comifin_mobile/";
const get = 'get/';
const post = 'add/';

List newPaiem = [];

List contrib = <String>[];
List acteGen = <String>[];
List moisData = <String>[];
List anneeData = <String>[];

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
      var response =
          await http.post(Uri.parse("$endPoint$post$url"), body: body);
      return response;
    } catch (e) {
      print(e.toString());
    }
    // ignore: null_check_always_fails
    return null!;
  }

  Future<http.Response> getData({url}) async {
    try {
      var response = await http.get(Uri.parse("$endPoint$get$url"));
      return response;
    } catch (e) {
      print(e);
    }
    // ignore: null_check_always_fails
    return null!;
  }
}
