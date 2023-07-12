import 'package:flutter/material.dart';

import '../../core/presentation/values/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double radius;
  final bool hasForwardIcon;
  final bool enable;

  PrimaryButton(
    this.title, {
    this.onPressed,
    this.radius = 0,
    this.hasForwardIcon = false,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 47),
      child: ElevatedButton(
        child: hasForwardIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              )
            : Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(kAccentWhiteColor),
          backgroundColor: MaterialStateProperty.all(enable ? kPrimaryGreenColor : Colors.grey),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
