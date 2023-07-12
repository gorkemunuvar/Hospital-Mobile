import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/doctor.dart';
import '../../utils/primary_text.dart';

class SmallDoctorCard extends StatelessWidget {
  const SmallDoctorCard(this.doctor);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext conetxt) {
    return GestureDetector(
      onTap: () => Get.toNamed('/doctorDetail', arguments: doctor),
      child: SizedBox(
        width: 175,
        height: 260,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 150,
                      child: doctor.image,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryText(
                  '${doctor.name} ${doctor.surname}',
                  Colors.black,
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                PrimaryText(
                  doctor.description ?? '',
                  Colors.grey,
                  maxLines: 3,
                  fontSize: 13,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
