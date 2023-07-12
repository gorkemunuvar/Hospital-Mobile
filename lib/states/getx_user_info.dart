import 'package:get/get.dart';

import '../core/utils/device_user_info_helper.dart';

class GetXUserInfoController extends GetxController {
  bool savedBefore = false;
  bool savedBeforeLoading = true;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> checkIfUserSavedBefore() async {
    savedBeforeLoading = true;
    savedBefore = await DeviceUserInfoHelper.savedBefore();
    savedBeforeLoading = false;
  }
}
