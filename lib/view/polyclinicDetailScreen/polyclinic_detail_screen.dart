import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:hospital/states/getx_base_states.dart';
import '../../models/doctor.dart';
import '../utils/primary_button.dart';

import '/models/doctor.dart';
import '/models/polyclinic.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_text.dart';
import 'utils/small_doctor_card.dart';
import '/controller/doctor.dart';

class PolyclinicDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PolyclinicModel polyclinicModel = Get.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(title: polyclinicModel.title, hasBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: size.height - 215,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Doktorlar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 260,
                              child: Scrollbar(child: MyDoctorsListViewFutureBuilder(polyclinicModel.id)),
                            ),
                          ),
                          //Arrow icon
                          Icon(Icons.arrow_forward_ios, size: 8),
                        ],
                      ),

                      SizedBox(height: 15),
                      //Bölüm Hakkında header
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: PrimaryText(
                          'polyclinicDetailsPage_about'.tr,
                          Colors.grey[800],
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),

                      Divider(),
                      SizedBox(height: 5),

                      _DescriptionText(polyclinicModel: polyclinicModel),
                      SizedBox(height: 15),
                      //Fiyat Listesi
                      GestureDetector(
                        child: PrimaryText(
                          'polyclinicDetailsPage_priceList'.tr,
                          Colors.blue,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Randevu al butonu
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: size.width,
                child: PrimaryButton('polyclinicDetailsPage_createButton'.tr, onPressed: () {
                  final GetXBaseStates baseStates = Get.find();
                  baseStates.polyclinicModel = polyclinicModel;

                  Get.toNamed('/getAppointment');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText({Key key, @required this.polyclinicModel}) : super(key: key);

  final PolyclinicModel polyclinicModel;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      polyclinicModel.description,
      expandText: 'polyclinicDetailsPage_viewMore'.tr,
      collapseText: 'polyclinicDetailsPage_viewLess'.tr,
      maxLines: 11,
      linkColor: Colors.blue,
      style: TextStyle(
        fontSize: 16,
        /*fontFamily: 'Rotunda',*/
      ),
    );
  }
}

class MyDoctorsListViewFutureBuilder extends StatefulWidget {
  final String polyclinicId;

  MyDoctorsListViewFutureBuilder(this.polyclinicId);

  @override
  _MyDoctorsListViewFutureBuilderState createState() => _MyDoctorsListViewFutureBuilderState();
}

class _MyDoctorsListViewFutureBuilderState extends State<MyDoctorsListViewFutureBuilder> {
  Future _myFuture;

  @override
  void initState() {
    super.initState();

    _myFuture = DoctorController.fetchDoctorsByPolyclinicId(widget.polyclinicId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<DoctorModel> doctors = snapshot.data;

            if (doctors.isEmpty) {
              return Center(child: PrimaryText('polyclinicDetailsPage_errMsg_doctorNotFound'.tr, Colors.black));
            }

            print('FIRST DOCTOR ID: ${doctors.first.id}');
            print('FIRST DOCTOR NAME: ${doctors.first.name}');
            print('FIRST DOCTOR DECRIPTION: ${doctors.first.description}');
            return ListView.builder(
              itemCount: doctors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => SmallDoctorCard(doctors[i]),
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
