import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/doctor.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_button.dart';
import '../utils/primary_text.dart';

Size size;

class DoctorDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DoctorModel doctor = Get.arguments;
    size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: MyAppBar(title: 'doctorDetailsPage_header'.tr, hasBackButton: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size.height - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Expanded(child: _DoctorInfoCard(doctor))]),
                    //Doctor Details Card
                    Expanded(
                      child: Card(
                        child: SizedBox(
                          width: size.width,
                          child: Scrollbar(child: _TabContent(doctor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Randevu al butonu
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: size.width,
                  child: PrimaryButton('doctorDetailsPage_createButton'.tr, onPressed: () => null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableText extends StatelessWidget {
  const _ExpandableText(this.text, {Key key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: ExpandableText(
          text ?? '',
          expandText: 'doctorDetailsPage_viewMore'.tr,
          collapseText: 'doctorDetailsPage_viewLess'.tr,
          maxLines: 13,
          linkColor: Colors.blue,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _DoctorInfoCard extends StatelessWidget {
  const _DoctorInfoCard(this.doctor, {Key key}) : super(key: key);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: doctor.image.image,
              //backgroundImage: Image.network('$ngrok${doctor.imagePath}').image,
            ),
            SizedBox(
              width: size.width / 4,
              child: const Divider(),
            ),
            PrimaryText(
              '${doctor.name} ${doctor.surname}',
              Colors.grey[800],
              fontSize: 15,
            ),
            const SizedBox(height: 5),
            PrimaryText(
              doctor.description ?? '',
              Colors.grey,
              textAlign: TextAlign.center,
              maxLines: 4,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent(this.doctor, {Key key}) : super(key: key);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MyTabBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 8, bottom: 12),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ExpandableText(doctor.profession),
                _ExpandableText(doctor.education),
                _ExpandableText(doctor.experience),
                _ExpandableText(doctor.achievements),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MyTabBar extends StatelessWidget {
  const _MyTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      labelColor: Colors.grey[800],
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        /*fontFamily: 'Rotunda',*/
        fontSize: 15,
      ),
      indicatorColor: Colors.transparent,
      //indicatorColor: Colors.transparent,
      tabs: [
        Tab(
          text: 'doctorDetailsPage_professionTab'.tr,
        ),
        Tab(
          text: 'doctorDetailsPage_educationTab'.tr,
        ),
        Tab(
          text: 'doctorDetailsPage_experienceTab'.tr,
        ),
        Tab(
          text: 'doctorDetailsPage_achievementsTab'.tr,
        ),
      ],
    );
  }
}
