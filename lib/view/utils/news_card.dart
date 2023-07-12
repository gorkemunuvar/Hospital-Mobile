import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/news.dart';
import 'primary_text.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Get.toNamed('/newsDetail', arguments: news),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //News image
                  Container(
                    width: size.width / 4.5,
                    height: size.height / 13.2,
                    child: news.image,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // News title
                        Container(
                          child: Container(
                            width: size.width * 0.60,
                            child: PrimaryText(
                              news.title,
                              Colors.grey[800],
                              fontSize: 15,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        //Date
                        PrimaryText(
                          news.date,
                          Colors.grey[700],
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
