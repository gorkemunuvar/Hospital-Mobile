import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/primary_text.dart';
import 'my_flutter_map.dart';

class HospitalLocationCard extends StatelessWidget {
  final double lat;
  final double long;
  final String address;
  final String name;

  HospitalLocationCard({this.lat, this.long, this.address, this.name});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'hospitalsPage_hospitalCardShowMap'.tr,
                    style: TextStyle(fontSize: 13, color: Color(0xff2d91e3)),
                  ),
                ],
              ),
              Divider(),
              Expanded(child: MyFlutterMap()),
              SizedBox(height: 10),
              PrimaryText('hospitalsPage_hospitalCardAdress'.tr, Colors.grey[700], fontSize: 15),
              Divider(),
              PrimaryText(address, Colors.grey[600], fontSize: 13, maxLines: 4),
            ],
          ),
        ),
      ),
    );
  }
}
