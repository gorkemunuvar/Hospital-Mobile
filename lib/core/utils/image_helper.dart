import 'dart:convert';

import 'package:flutter/cupertino.dart';

Image getImageByBase64(String imageBase64, String defaultImagePath) {
  if (imageBase64 != null) {
    if (imageBase64.isNotEmpty) {
      final imageBytes = base64Decode(imageBase64);
      return Image.memory(imageBytes, fit: BoxFit.fill);
    } else {
      return Image.asset(defaultImagePath);
    }
  } else {
    return Image.asset(defaultImagePath);
  }
}
