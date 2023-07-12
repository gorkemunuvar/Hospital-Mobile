import 'package:get/get.dart';

import '/models/polyclinic.dart';
import '/controller/polyclinic.dart';

class GetxPolyclinicsController extends GetxController {
  bool isLoading = true;
  List<PolyclinicModel> polyclinics = [];

  @override
  void onInit() {
    super.onInit();

    fetchPolyclinics();
  }

  Future<void> fetchPolyclinics() async {
    isLoading = true;
    polyclinics = await PolyclinicController.fetchPolyclinics();
    isLoading = false;

    update();
  }
}
