import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/appointment.dart';
import '../../../core/presentation/values/app_colors.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../models/appointment.dart';
import '../../../states/getx_my_appointments.dart';
import '../../utils/primary_text.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(this.appointment, {this.isActive = true});

  final AppointmentModel appointment;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: isActive ? Colors.green : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 25,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(width: 5),
                      PrimaryText(
                        appointment.time,
                        Colors.grey[800],
                        fontSize: 18,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 25,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(width: 5),
                      PrimaryText(
                        appointment.date,
                        Colors.grey[800],
                        fontSize: 18,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            appointment.doctorName != null ? _DoctorInfoLabel(appointment: appointment) : const SizedBox.shrink(),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/clinic.png'),
                      color: kPrimaryGreenColor,
                    ),
                    const SizedBox(width: 5),
                    PrimaryText(appointment.profession.name, Colors.grey[700]),
                  ],
                ),
                isActive
                    ? Card(
                        color: Colors.red,
                        child: InkWell(
                          onTap: () => _onCancelButtonTap(appointment),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}

class _DoctorInfoLabel extends StatelessWidget {
  const _DoctorInfoLabel({Key key, @required this.appointment}) : super(key: key);

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            ImageIcon(
              AssetImage('assets/icons/doctor.png'),
              color: kPrimaryGreenColor,
            ),
            SizedBox(width: 5),
            PrimaryText('${appointment.doctorName} ${appointment.doctorSurname}', Colors.grey[700]),
          ],
        ),
      ],
    );
  }
}

class _CancelDialog extends StatelessWidget {
  const _CancelDialog(this.appointment, {Key key}) : super(key: key);

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("appointmentsPage_cancelDialog_title".tr),
      content: Text("appointmentsPage_cancelDialog_content".trParams({
        'appointmentDate': appointment.date,
        'appointmentHour': appointment.time,
      })),
      actions: [
        TextButton(onPressed: () => Get.back(result: true), child: Text("dialog_yes".tr)),
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            "dialog_no".tr,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

Future<void> _onCancelButtonTap(AppointmentModel appointment) async {
  var dialogResult = await Get.dialog(_CancelDialog(appointment));

  if (dialogResult != null && dialogResult) {
    bool isCancelled = await Appointment.cancelAppointment(appointment.id);
    if (isCancelled) {
      _showCancelledMessage();
      _refreshUI();
    } else {
      _showDeniedMessage();
    }
  }
}

void _showCancelledMessage() =>
    SnackbarHelper.show('Bilgilendirme', 'Randevu kaydınız başarıyla silindi.', Colors.green);

void _showDeniedMessage() => SnackbarHelper.show('Bilgilendirme', 'Randevu kaydınız silinemedi.', Colors.red);

void _refreshUI() {
  final GetxMyAppointments myAppointmentsStates = Get.find();
  myAppointmentsStates.fetchActiveAppointments();
}
