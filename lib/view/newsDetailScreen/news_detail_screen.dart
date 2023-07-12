import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/news.dart';
import '../../core/presentation/values/app_colors.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_text.dart';

class NewsDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsModel news = Get.arguments;

    return Scaffold(
      appBar: MyAppBar(hasBackButton: true, title: 'newsDetailsPage_header'.tr),
      //Share button
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('tapped.'),
        backgroundColor: kPrimaryGreenColor,
        child: Icon(
          Icons.share,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: news.image,
                ),
              ),
              SizedBox(height: 20),

              //News Title
              PrimaryText(news.title.trim(), Colors.grey[800], fontSize: 25, maxLines: 20),
              SizedBox(height: 10),

              //News Date
              PrimaryText(news.date.trim(), Colors.grey[600], fontSize: 13),
              SizedBox(height: 20),

              //News Description
              PrimaryText(
                news.description.trim(),
                Colors.grey[900],
                fontSize: 16,
                maxLines: 1000,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
