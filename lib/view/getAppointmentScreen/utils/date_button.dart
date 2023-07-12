import 'package:flutter/material.dart';

import '../../../core/presentation/values/app_colors.dart';

class DateButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onPressed;

  DateButton({this.title, this.isSelected = false, this.onPressed});

  final Color textColor = Color(0xffc0c0c0);
  final Color backgroundColor = Color(0xfff4f5f9);

  @override
  Widget build(BuildContext context) {
    Color textColor, backgroundColor;

    if (isSelected) {
      textColor = Colors.white;
      backgroundColor = kSecondaryGreenColor;
    } else {
      textColor = Color(0xffc0c0c0);
      backgroundColor = Color(0xfff4f5f9);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        ),
      ),
    );
  }
}
