import 'package:flutter/material.dart';

import '../../core/presentation/values/app_colors.dart';
import 'backButton.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    String title = "",
    Color color = kPrimaryGreenColor,
    Color titleColor = Colors.white,
    bool hasBackButton = false,
    TabBar tabbar,
    double height = 56,
    List<Widget> actions,
  }) : super(
          toolbarHeight: height,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: color,
          leading: hasBackButton
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: MyBackButton(),
                )
              : Container(),
          bottom: tabbar,
          actions: actions,
        );
}
