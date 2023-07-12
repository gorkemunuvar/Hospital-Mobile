import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hospital/view/utils/primary_text.dart';
import 'package:latlong2/latlong.dart';
import 'package:hospital/view/hospitalLocationsScreen/utils/my_flutter_map.dart';

import '../utils/my_appbar.dart';
import 'utils/hospital_location_card.dart';

List<HospitalLocationCard> hospitalLocationCards = [
  HospitalLocationCard(
    lat: 50.281535,
    long: 57.2235613,
    address:
        'Айгерим​центр красоты и здоровья , ​Актобе, Алматы район, Шернияза, 35',
    name: 'Айгерим',
  ),
  HospitalLocationCard(
    lat: 50.2987449,
    long: 57.1464832,
    address: 'Айгерим центр красоты и здоровья, ​Актобе,  Пацаева 7',
    name: 'Айгерим',
  ),
  HospitalLocationCard(
    lat: 50.299994,
    long: 57.150883,
    address: 'Айгерим центр красоты и здоровья​, Актобе, Маресьева 87',
    name: 'Айгерим',
  ),
];

class HospitalLocationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'hospitalsPage_header'.tr, hasBackButton: true),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(
              child: MyFlutterMap(
                points: [
                  LatLng(50.281535, 57.2235613),
                  LatLng(50.2987449, 57.1464832),
                  LatLng(50.299994, 57.150883),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(width: 10),
                        Expanded(
                          child: PrimaryText(
                              'Айгерим​центр красоты и здоровья , ​Актобе, Алматы район, Шернияза, 35',
                              Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(width: 10),
                        Expanded(
                          child: PrimaryText(
                              'Айгерим центр красоты и здоровья, ​Актобе,  Пацаева 7',
                              Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(width: 10),
                        Expanded(
                          child: PrimaryText(
                              'Айгерим центр красоты и здоровья​, Актобе, Маресьева 87',
                              Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Expanded(
                          child: PrimaryText('+7 (7132) 905-100', Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Expanded(
                          child:
                              PrimaryText('+7 (775) 0 905-100', Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Expanded(
                          child:
                              PrimaryText('+7 (778) 0 905 100', Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10) +
                            EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(width: 10),
                        Expanded(
                          child: PrimaryText('call@aigerim.info', Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),

      // Column(
      //   children: [
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: _HospitalLocationsListView(),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class _HospitalLocationsListView extends StatelessWidget {
  const _HospitalLocationsListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: hospitalLocationCards.length,
      itemBuilder: (context, i) => hospitalLocationCards[i],
      separatorBuilder: (context, i) => SizedBox(height: 5),
    );
  }
}
