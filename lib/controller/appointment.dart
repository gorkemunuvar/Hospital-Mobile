import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/config/app_constants.dart';
import '../core/enums/enums.dart';
import '../models/appointment.dart';

class Appointment {
  static Future<AppointmentResult> createAppointment(AppointmentModel appointment) async {
    int statusCode = 0;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final url = '$ngrok/appointments';
    final body = {
      'patient_id': appointment.patientId,
      'profession_id': appointment.profession.id,
      'doctor_id': appointment.doctor.id ?? '',
      'patient_name': appointment.patientName,
      'patient_surname': appointment.patientSurname,
      'date': appointment.date,
      'time': appointment.time,
      'note': appointment.note ?? ''
    };

    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      statusCode = response.statusCode;
    } catch (e) {
      print('ERROR LOG: $e');
    }

    return _getAppointmentResult(statusCode);
  }

  static Future<List<AppointmentModel>> fetchActiveAppointments(String patientId) =>
      _fetchAppointments(patientId, AppointmentType.active);

  static Future<List<AppointmentModel>> fetchPastAppointments(String patientId) =>
      _fetchAppointments(patientId, AppointmentType.past);

  static Future<List<AppointmentModel>> _fetchAppointments(String patientId, AppointmentType appointmentType) async {
    List<AppointmentModel> appointments;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final activeAppointmentsUrl = '$ngrok/patients/$patientId/appointments/active';
    final pastAppointmentsUrl = '$ngrok/patients/$patientId/appointments/past';
    final url = appointmentType == AppointmentType.active ? activeAppointmentsUrl : pastAppointmentsUrl;

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['appointments'] as List;
        appointments = jsonList.map((json) => AppointmentModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return appointments;
  }

  static Future<List<String>> fetchAvailableDatesByDoctorId(String id, String professionId) async {
    final url = '$ngrok/professions/$professionId/doctors/$id/available-dates';
    return await _fetchAvailableDates(url);
  }

  static Future<List<String>> fetchAvailableDatesByProfessionId(String id) async {
    final url = '$ngrok/professions/$id/available-dates';
    return await _fetchAvailableDates(url);
  }

  static Future<List<String>> _fetchAvailableDates(String url) async {
    List<String> availableDates;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['available_dates'] as List;
        availableDates = List<String>.from(jsonList);
      }
    } catch (e) {
      print(e);
    }

    return availableDates;
  }

  static Future<List<String>> fetchAvailableTimes(String date, {String doctorId = ''}) async {
    List<String> availableTimes;
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final String urlByProfession = '$ngrok/available_dates/$date/available_times';
    final String urlByDoctorId = '$ngrok/doctors/$doctorId/available_dates/$date/available_times';
    final url = doctorId.isEmpty ? urlByProfession : urlByDoctorId;

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['available_times'] as List;
        availableTimes = List<String>.from(jsonList);
      }
    } catch (e) {
      print(e);
    }

    return availableTimes;
  }

  static Future<bool> cancelAppointment(String appointmentId) async {
    bool isCancelled = false;
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final url = '$ngrok/appointments/$appointmentId';

    try {
      http.Response response = await http.put(Uri.parse(url), headers: headers);
      isCancelled = response.statusCode == 200;
    } catch (e) {
      print(e);
    }

    return isCancelled;
  }
}

AppointmentResult _getAppointmentResult(int statusCode) {
  switch (statusCode) {
    case 201:
      return AppointmentResult.confirmed;
    case 409:
      return AppointmentResult.alreadyTaken;
    case 500:
      return AppointmentResult.error;
  }

  return AppointmentResult.error;
}
