import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../states/getx_appointment_info.dart';
import '../../../states/getx_doctors_controller.dart';
import '../../../states/getx_polyclinics_controller.dart';
import '../../utils/primary_text.dart';
import 'service_button.dart';

class ServicesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText('homePage_servicesCard_header'.tr, Colors.grey[800],
                fontSize: 15),
            Divider(),
            SizedBox(height: 5),
            SizedBox(
              height: 125,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 290,
                      child: Scrollbar(
                        child: ListView.separated(
                          itemCount: serviceButtons.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => serviceButtons[i],
                          separatorBuilder: (context, i) => SizedBox(width: 10),
                        ),
                      ),
                    ),
                  ),
                  //Arrow icon
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<ServiceButton> serviceButtons = [
    ServiceButton(
      'homePage_servicesCard_myAppointments'.tr,
      'assets/icons/appointment.png',
      () {
        Get.put(GetxAppointmentInfoStates());

        final pageAfterLoginScreen = '/appointments';
        Get.toNamed('/login', arguments: pageAfterLoginScreen);
      },
    ),
    ServiceButton(
      'homePage_servicesCard_newAppointment'.tr,
      'assets/icons/appointment.png',
      () {
        final getxAppointmentInfoStates = Get.put(GetxAppointmentInfoStates());
        getxAppointmentInfoStates.refreshStates();

        final pageAfterLoginScreen = '/getAppointment';
        Get.toNamed('/login', arguments: pageAfterLoginScreen);
      },
    ),
    ServiceButton(
      'Lab Sonuçları',
      'assets/icons/building.png',
      () {
        Get.toNamed('/labResults');
      },
      iconScale: 1,
    ),
    ServiceButton(
      'homePage_servicesCard_polyclinics'.tr,
      'assets/icons/building.png',
      () {
        Get.put(GetxPolyclinicsController());
        Get.toNamed('/polyclinics');
      },
      iconScale: 1,
    ),
    ServiceButton(
      'homePage_servicesCard_doctors'.tr,
      'assets/icons/doctor.png',
      () {
        Get.put(GetxDoctorsController());
        Get.toNamed('/doctors');
      },
    ),
    ServiceButton(
      'homePage_servicesCard_hospitals'.tr,
      'assets/icons/building.png',
      () => Get.toNamed('/hospitalLocations'),
      iconScale: 1,
    ),
  ];
}
