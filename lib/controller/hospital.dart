import 'dart:convert';

import 'package:hospital/core/logger/app_logger.dart';
import 'package:http/http.dart' as http;

import '../core/config/app_constants.dart';
import '/models/hospital.dart';

class HospitalController {
  static String _url = '$ngrok/hospitals';

  static Future<List<HospitalModel>> fetchHospitals() async {
    List<HospitalModel> hospitals;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        Uri.parse(_url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['hospitals'] as List;
        hospitals = jsonList.map((json) => HospitalModel.fromJson(json)).toList();

        for (var item in hospitals) {
          AppLogger.wtf(item.name);
        }
      }
    } catch (e) {
      print(e);
    }

    return hospitals;
  }
}
