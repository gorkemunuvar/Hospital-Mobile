import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool onlyDigits;
  final TextEditingController controller;
  final Function onChanged;

  PrimaryTextField({
    this.hintText,
    this.labelText,
    this.onlyDigits = false,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.bottom, //it works if the height is 40
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
        keyboardType: onlyDigits ? TextInputType.number : null,
        inputFormatters: onlyDigits ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : null,
      ),
    );
  }
}
