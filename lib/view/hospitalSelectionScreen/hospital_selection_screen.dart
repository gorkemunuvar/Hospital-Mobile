import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/models/hospital.dart';
import 'package:hospital/states/getx_appointment_info.dart';

import '../../controller/hospital.dart';
import '../../states/getx_hospital_selection.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_button.dart';
import '../utils/primary_text.dart';

final GetxHospitalSelection getxHospitalSelection = Get.find();

class HospitalSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(hasBackButton: true, title: 'Hastane Seçimi'),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _HospitalPickerFutureBuilder(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 20, top: 0),
                child: PrimaryButton('Devam', hasForwardIcon: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HospitalPickerFutureBuilder extends StatefulWidget {
  const _HospitalPickerFutureBuilder({Key key}) : super(key: key);

  @override
  State<_HospitalPickerFutureBuilder> createState() => _HospitalPickerFutureBuilderState();
}

class _HospitalPickerFutureBuilderState extends State<_HospitalPickerFutureBuilder> {
  Future _hospitalsFuture;

  @override
  void initState() {
    _hospitalsFuture = HospitalController.fetchHospitals();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _hospitalsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<HospitalModel> _hospitals = snapshot.data;
            return _HospitalPicker(_hospitals);
          }
        }

        return Center(
          child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}

class _HospitalPicker extends StatefulWidget {
  _HospitalPicker(this.hospitals, {Key key}) : super(key: key);

  final List<HospitalModel> hospitals;

  @override
  State<_HospitalPicker> createState() => _HospitalPickerState();
}

class _HospitalPickerState extends State<_HospitalPicker> {
  List<PrimaryText> children;

  @override
  void initState() {
    super.initState();

    children = widget.hospitals.map((hospital) => PrimaryText(hospital.name, Colors.black, fontSize: 16)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      children: children,
      itemExtent: 18,
      diameterRatio: 1,
      useMagnifier: true,
      magnification: 1.5,
      onSelectedItemChanged: (selectedIndex) {
        final getxAppointmentInfoController = Get.put(GetxAppointmentInfoStates());
        getxAppointmentInfoController.appointment.hospital = widget.hospitals[selectedIndex];
        getxHospitalSelection.updateHospitalSelection(true);
      },
    );
  }
}
