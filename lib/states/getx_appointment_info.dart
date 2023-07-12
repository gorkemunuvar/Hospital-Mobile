//Here are the states for 'Get Appointment' screen
import 'package:get/get.dart';
import 'package:hospital/controller/appointment.dart';
import 'package:hospital/controller/doctor.dart';
import 'package:hospital/controller/hospital.dart';
import 'package:hospital/controller/profession.dart';
import 'package:hospital/models/appointment.dart';
import 'package:hospital/models/doctor.dart';
import 'package:hospital/models/hospital.dart';
import 'package:hospital/models/profession.dart';

import '/controller/polyclinic.dart';
import '/models/polyclinic.dart';

class GetxAppointmentInfoStates extends GetxController {
  bool areHospitalsLoaded = false;
  bool arePolyclinicsLoaded = false;
  bool areProfessionsLoaded = false;
  bool areDoctorsLoaded = false;
  bool areAvailableDatesLoaded = false;
  bool areAvailableTimesLoaded = false;

  bool isHospitalSelected = false;
  bool isPolyclinicSelected = false;
  bool isProfessionSelected = false;
  bool isDoctorSelected = false;
  bool isAvailableDateSelected = false;
  bool isAvailableTimeSelected = false;

  final appointment = AppointmentModel();

  List<HospitalModel> hospitals = [];
  List<PolyclinicModel> polyclinics = [];
  List<ProfessionModel> professions = [];
  List<DoctorModel> doctors = [];
  List<String> availableAppointmentDates = [];
  List<String> availableAppointmentTimes = [];

  @override
  void onInit() {
    super.onInit();

    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    areHospitalsLoaded = false;
    hospitals = await HospitalController.fetchHospitals();
    areHospitalsLoaded = true;

    update();
  }

  Future<void> fetchPolyclinics() async {
    arePolyclinicsLoaded = false;
    polyclinics = await PolyclinicController.fetchPolyclinics();
    arePolyclinicsLoaded = true;

    update();
  }

  Future<void> fetchProfessionsByPolyclinicId(String id) async {
    areProfessionsLoaded = false;
    professions = await ProfessionController.fetchProfessionsByPolyclinicId(id);
    areProfessionsLoaded = true;

    update();
  }

  Future<void> fetchDoctorsByProfessionId(String id) async {
    areDoctorsLoaded = false;
    doctors = await DoctorController.fetchDoctorsByProfessionId(id);
    areDoctorsLoaded = true;

    update();
  }

  Future<void> fetchAvailableDatesByDoctorId(String id, String professionId) async {
    areAvailableDatesLoaded = false;
    availableAppointmentDates = await Appointment.fetchAvailableDatesByDoctorId(id, professionId);
    areAvailableDatesLoaded = true;

    update();
  }

  Future<void> fetchAvailableDatesByProfessionId(String id) async {
    areAvailableDatesLoaded = false;
    availableAppointmentDates = await Appointment.fetchAvailableDatesByProfessionId(id);
    areAvailableDatesLoaded = true;

    update();
  }

  Future<void> fetchAvailableTimes(String date, {String doctorId = ''}) async {
    areAvailableTimesLoaded = false;

    Future availableTimesFuture = doctorId.isEmpty
        ? Appointment.fetchAvailableTimes(date)
        : Appointment.fetchAvailableTimes(date, doctorId: doctorId);

    availableAppointmentTimes = await availableTimesFuture;
    areAvailableTimesLoaded = true;

    update();
  }

  void refreshStates() {
    areHospitalsLoaded = false;
    arePolyclinicsLoaded = false;
    areProfessionsLoaded = false;
    areDoctorsLoaded = false;
    areAvailableDatesLoaded = false;
    areAvailableTimesLoaded = false;

    isHospitalSelected = false;
    isPolyclinicSelected = false;
    isProfessionSelected = false;
    isDoctorSelected = false;
    isAvailableDateSelected = false;
    isAvailableTimeSelected = false;

    hospitals = [];
    polyclinics = [];
    professions = [];
    doctors = [];
    availableAppointmentDates = [];
    availableAppointmentTimes = [];
  }
}
