import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/doctor.dart';
import '../core/config/app_constants.dart';

class DoctorController {
  static String _url = '$ngrok/doctors';

  static Future<List<DoctorModel>> fetchDoctors(int page) async {
    List<DoctorModel> news;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      String query = _url + '/$page';

      http.Response response = await http.get(Uri.parse(query), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['doctors'] as List;
        news = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return news;
  }

  static Future<List<DoctorModel>> fetchDoctorsByPolyclinicId(String id) async {
    List<DoctorModel> doctors = [];
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(Uri.parse('$ngrok/polyclinics/$id/doctors'), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['doctors'] as List;
        doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return doctors;
  }

  static Future<List<DoctorModel>> fetchDoctorsByProfessionId(String id) async {
    List<DoctorModel> doctors;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        Uri.parse('$ngrok/professions/$id/doctors'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['doctors'] as List;
        doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return doctors;
  }

  static Future<List<DoctorModel>> searchDoctor(String searchText) async {
    List<DoctorModel> doctors;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(
        Uri.parse('$ngrok/doctors/search/$searchText'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['search_result'] as List;
        doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return doctors;
  }
}
