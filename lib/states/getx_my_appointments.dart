import 'package:get/get.dart';

import '../controller/appointment.dart';
import '../models/appointment.dart';
import 'getx_base_states.dart';

final GetXBaseStates _baseStates = Get.find();

class GetxMyAppointments extends GetxController {
  bool isActiveAppointmentsLoading = true;
  bool isPastAppointmentsLoading = true;

  List<AppointmentModel> activeAppointments = [];
  List<AppointmentModel> pastAppointments = [];

  @override
  onInit() {
    super.onInit();
    fetchActiveAppointments();
    fetchPastAppointments();
  }

  Future<void> fetchActiveAppointments() async {
    isActiveAppointmentsLoading = true;
    activeAppointments = await Appointment.fetchActiveAppointments(_baseStates.patient.id);
    isActiveAppointmentsLoading = false;

    _logAppointments('ACTIVE APPOINTMENTS', activeAppointments);
    update();
  }

  Future<void> fetchPastAppointments() async {
    isPastAppointmentsLoading = true;
    pastAppointments = await Appointment.fetchPastAppointments(_baseStates.patient.id);
    isPastAppointmentsLoading = false;

    _logAppointments('PAST APPOINTMENTS', pastAppointments);
    update();
  }

  void _logAppointments(String title, List<AppointmentModel> appointments) {
    print(title);
    print('----------------');
    appointments.forEach((appointment) => print('APPOINTMENT ID: ${appointment.id}'));
  }
}
