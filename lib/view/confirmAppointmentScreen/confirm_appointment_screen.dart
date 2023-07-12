import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/utils/my_appbar.dart';
import '../../controller/appointment.dart';
import '../../core/enums/enums.dart';
import '../../core/presentation/values/app_colors.dart';
import '../../models/doctor.dart';
import '../../states/getx_appointment_info.dart';
import '../utils/primary_button.dart';

final GetxAppointmentInfoStates _appointmentStates = Get.find();

class ConfirmAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(
        title: 'appointmentConfirmationPage_header'.tr,
        hasBackButton: true,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: const _InfoFields(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: size.width,
                    child: PrimaryButton(
                      'appointmentConfirmationPage_confirmButton'.tr,
                      onPressed: _onConfirmButtonPressed,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoFields extends StatelessWidget {
  const _InfoFields({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoLabelWithIcon(
          icon: Icon(Icons.local_hospital_sharp, color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_hospital'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) => MyText(c.appointment.hospital.name, Colors.grey[700]),
        ),
        SizedBox(height: 20),
        _InfoLabelWithIcon(
          icon: ImageIcon(AssetImage('assets/icons/clinic.png'), color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_polyclinic'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) => MyText(c.appointment.polyclinic.title, Colors.grey[700]),
        ),
        SizedBox(height: 20),
        _InfoLabelWithIcon(
          icon: ImageIcon(AssetImage('assets/icons/clinic.png'), color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_profession'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) => MyText(c.appointment.profession.name, Colors.grey[700]),
        ),
        SizedBox(height: 20),
        _appointmentStates.isDoctorSelected ? _DoctorInfoField() : SizedBox.shrink(),
        _InfoLabelWithIcon(
          icon: Icon(Icons.date_range, color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_appointmentDate'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) => MyText(c.appointment.date, Colors.grey[700]),
        ),
        SizedBox(height: 20),
        _InfoLabelWithIcon(
          icon: Icon(Icons.timer_rounded, color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_appointmentTime'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) => MyText(c.appointment.time, Colors.grey[700]),
        ),
      ],
    );
  }
}

class _DoctorInfoField extends StatelessWidget {
  const _DoctorInfoField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoLabelWithIcon(
          icon: ImageIcon(AssetImage('assets/icons/doctor.png'), color: kPrimaryGreenColor),
          title: 'appointmentConfirmationPage_doctor'.tr,
        ),
        Divider(),
        GetBuilder<GetxAppointmentInfoStates>(
          builder: (c) {
            DoctorModel doctor = c.appointment.doctor;
            String doctorFullName = '${doctor.name} ${doctor.surname}';

            return MyText(doctorFullName, Colors.grey[700]);
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class _InfoLabelWithIcon extends StatelessWidget {
  const _InfoLabelWithIcon({this.icon, this.title, Key key}) : super(key: key);

  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, SizedBox(width: 5), MyText(title, kPrimaryGreenColor)],
    );
  }
}

class MyText extends StatelessWidget {
  final String title;
  final Color color;

  MyText(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        /*fontFamily: 'Rotunda',*/
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

void _onConfirmButtonPressed() async {
  final AppointmentResult result = await _createAppointment();
  Get.toNamed('/appointmentResult', arguments: result);
}

Future<AppointmentResult> _createAppointment() async {
  final appointment = _appointmentStates.appointment;
  return await Appointment.createAppointment(appointment);
}
