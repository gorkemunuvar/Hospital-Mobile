import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/doctor.dart';
import 'primary_text.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard(this.doctor);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Get.toNamed('/doctorDetail', arguments: doctor),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 12,
                top: 24,
                bottom: 24,
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: doctor.image.image,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    '${doctor.name} ${doctor.surname}',
                    Colors.grey[700],
                    maxLines: 2,
                    fontSize: 16,
                  ),
                  SizedBox(height: 2),
                  Container(
                    width: size.width * 0.5,
                    child: PrimaryText(
                      doctor.description ?? '',
                      Colors.grey,
                      fontSize: 14.5,
                      maxLines: 3,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
