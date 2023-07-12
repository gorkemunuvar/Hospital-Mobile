import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(
    this.title,
    this.color, {
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.start,
    this.maxLines = 2,
  });

  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        // fontFamily: 'Rotunda',
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
