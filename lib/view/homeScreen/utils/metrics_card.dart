import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'metric_info.dart';

class MetricsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MetricInfo(
              'assets/icons/doctor.png',
              '170',
              'homePage_metricsIcon1'.tr,
              iconScale: 0.7,
            ),
            MetricInfo(
              'assets/icons/people.png',
              '28.000',
              'homePage_metricsIcon2'.tr,
              iconScale: 0.8,
            ),
            MetricInfo(
              'assets/icons/building.png',
              '3',
              'homePage_metricsIcon3'.tr,
              iconScale: 1.3,
            ),
            MetricInfo(
              'assets/icons/stetescope.png',
              '150',
              'homePage_metricsIcon4'.tr,
              iconScale: 0.6,
            ),
          ],
        ),
      ),
    );
  }
}
