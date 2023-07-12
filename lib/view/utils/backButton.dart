import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyBackButton extends IconButton {
  MyBackButton()
      : super(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () => Get.back(),
        );
}
