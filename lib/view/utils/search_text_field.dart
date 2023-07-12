import 'package:flutter/material.dart';

import '../../core/presentation/values/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final Function onTap;

  SearchTextField({this.hintText = '', @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      cursorColor: kPrimaryGreenColor,
      style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.bold,
        /*fontFamily: 'Rotunda',*/
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 15),
        fillColor: Color(0xfff4f4ff),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffb1b0b6),
          fontWeight: FontWeight.bold,
          /*fontFamily: 'Rotunda',*/
        ),
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xff8f8f8d),
        ),
      ),
    );
  }
}
