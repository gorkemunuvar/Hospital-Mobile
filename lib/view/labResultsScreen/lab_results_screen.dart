import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hospital/view/labResultDetailScreen/lab_result_detail_screen.dart';
import 'package:hospital/view/utils/primary_text.dart';

import '/view/utils/my_appbar.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'labResultsPage_header'.tr,
        hasBackButton: true,
        height: 66,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 10,
        itemBuilder: (context, item) => Card(
          margin: const EdgeInsets.only(bottom: 20),
          elevation: 3,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("labResultsPage_appointment_date".tr),
                            PrimaryText("20.02.2022", Colors.black)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("labResultsPage_test_result_date".tr),
                            PrimaryText("21.02.2022", Colors.black)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("labResultsPage_test_type".tr),
                  PrimaryText("Kan Testi", Colors.red[800]),
                ],
              ),
            ),
            onTap: () {
              Get.to(() => LabResultDetailScreen());
            },
          ),
        ),
      ),
    );
  }
}
