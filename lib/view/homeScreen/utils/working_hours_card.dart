import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/primary_text.dart';

class WorkingHoursCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText('homePage_workingHours'.tr, Colors.grey[800], fontSize: 15),
            Divider(),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    PrimaryText('07:00 - 22:00', Colors.grey[700], fontSize: 15),
                    SizedBox(height: 5),
                    PrimaryText('homePage_workingHours_weekdays'.tr, Colors.grey[700], fontSize: 12),
                  ],
                ),
                Column(
                  children: [
                    PrimaryText('08:00 - 18:00', Colors.grey[700], fontSize: 15),
                    SizedBox(height: 5),
                    PrimaryText('homePage_workingHours_saturday'.tr, Colors.grey[700], fontSize: 12),
                  ],
                ),
                Column(
                  children: [
                    PrimaryText('08:00 - 18:00', Colors.grey[700], fontSize: 15),
                    SizedBox(height: 5),
                    PrimaryText('homePage_workingHours_sunday'.tr, Colors.grey[700], fontSize: 12),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
