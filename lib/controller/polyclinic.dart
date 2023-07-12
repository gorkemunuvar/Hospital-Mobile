import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/config/app_constants.dart';
import '/models/polyclinic.dart';

class PolyclinicController {
  static String _url = '$ngrok/polyclinics';

  static Future<List<PolyclinicModel>> fetchPolyclinics() async {
    List<PolyclinicModel> polyclinics = [];
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(Uri.parse(_url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['polyclinics'] as List;
        polyclinics = jsonList.map((json) => PolyclinicModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return polyclinics;
  }

  static Future<List<PolyclinicModel>> searchPolyclinic(String searchString) async {
    if (searchString.isEmpty) return [];

    List<PolyclinicModel> polyclinics = [];
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        Uri.parse('$ngrok/polyclinics/search/$searchString'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['search_result'] as List;
        polyclinics = jsonList.map((json) => PolyclinicModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return polyclinics;
  }
}
