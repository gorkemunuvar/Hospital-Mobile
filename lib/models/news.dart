import 'dart:convert';

import 'package:flutter/cupertino.dart';

class NewsModel {
  String id;
  String title;
  String description;
  String date;
  Image image;

  NewsModel(this.id, this.title, this.description, this.date, this.image);

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    Image image;
    String imageBase64 = json['image_base64'];

    if (imageBase64 != null) {
      if (imageBase64.isNotEmpty) {
        final imageBytes = base64Decode(imageBase64);
        image = Image.memory(imageBytes, fit: BoxFit.fill);
      } else {
        image = Image.asset('assets/images/doctor_avatar.png');
      }
    } else {
      image = Image.asset('assets/images/doctor_avatar.png');
    }

    return NewsModel(
      json['id'],
      json['title'],
      json['description'],
      json['date'],
      image,
    );
  }
}
