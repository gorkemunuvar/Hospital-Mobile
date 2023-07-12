import 'package:get/get.dart';

import '../models/hospital.dart';

class GetxHospitalSelection extends GetxController {
  HospitalModel hospital;
  bool isHospitalSelected = false;

  void updateHospitalSelection(bool value) {
    isHospitalSelected = value;
    update();
  }
}
