import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Icons.warning_rounded, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
