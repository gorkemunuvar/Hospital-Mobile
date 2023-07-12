import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/config/app_constants.dart';
import '/models/profession.dart';

class ProfessionController {
  static final String _url = '$ngrok';

  static Future<List<ProfessionModel>> fetchProfessionsByPolyclinicId(String id) async {
    List<ProfessionModel> professions;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      String query = _url + '/polyclinics/$id/professions';

      http.Response response = await http.get(
        Uri.parse(query),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['professions'] as List;
        professions = jsonList.map((json) => ProfessionModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return professions;
  }
}
