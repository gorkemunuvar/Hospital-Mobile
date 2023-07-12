import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/patient.dart';
import '../core/config/app_constants.dart';

class PatientController {
  static String _url = '$ngrok/create_patient';
  
  static Future<String> createPatientIdIfNotExist(PatientModel patient) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    PatientModel patientResult;
    try {
      String body = jsonEncode(patient.toJson());
      http.Response response = await http.post(Uri.parse(_url), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        patientResult = PatientModel.fromJson(jsonDecode(response.body)['patient']);
      } else {
        return "-1";
      }
    } catch (e) {
      print(e);
    }

    return patientResult.id;
  }
}
