import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:hospital/view/utils/my_appbar.dart';
import 'package:hospital/view/utils/primary_text.dart';

class LabResultDetailScreen extends StatelessWidget {
  const LabResultDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "labResultDetailPage_header".tr,
        hasBackButton: true,
        height: 66,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headingRow("Test Türü:", "Kan Testi"),
              headingRow("Randevu Tarihi:", "20.02.2022"),
              headingRow("Test Sonucu Tarihi:", "21.02.2022"),
              SizedBox(height: 20),
              DataTable(
                columnSpacing: 40,
                columns: [
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text("Değer İsmi"),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Referans\nAralığı",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text("Değer"),
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      myCell("Monosit Yüzdesi"),
                      myCell("0 - 12"),
                      myCell("10.5 %"),
                    ],
                  ),
                  DataRow(
                    cells: [
                      myCell("Lenfosit Yüzdesi"),
                      myCell("20 - 50.3"),
                      myCell("34.3 %"),
                    ],
                  ),
                  DataRow(
                    cells: [
                      myCell("Hemoglobin (HGB)"),
                      myCell("14 - 18"),
                      myCell("16.7 g/dL"),
                    ],
                  ),
                  DataRow(
                    cells: [
                      myCell("Hematokrit"),
                      myCell("41 - 53"),
                      myCell("50.9 %"),
                    ],
                  ),
                  DataRow(
                    cells: [
                      myCell("Trombosit (PLT)"),
                      myCell("171 - 392"),
                      myCell("206.1"),
                    ],
                  ),
                  DataRow(
                    cells: [
                      myCell("Nötrofil Yüzdesi"),
                      myCell("43 - 73"),
                      myCell("49.6 %"),
                    ],
                  ),
                ],
              ),
              // Table(
              //   children: [
              //     TableRow(
              //       decoration: BoxDecoration(),
              //       children: [
              //         Text("Monosit Yüzdesi"),
              //         Center(child: Text("0 - 12")),
              //         Center(child: Text("10.5 %")),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingRow(String key, String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              key,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10),
            PrimaryText(
              value,
              Colors.black,
              fontSize: 18,
            ),
          ],
        ),
      );

  DataCell myCell(String value) => DataCell(
        Center(
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
