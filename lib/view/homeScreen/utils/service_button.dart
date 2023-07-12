import 'package:flutter/material.dart';
import 'package:hospital/core/presentation/values/app_colors.dart';

import '../../utils/primary_text.dart';

class ServiceButton extends StatelessWidget {
  final String title;
  final String assetIconPath;
  final double iconScale;
  final Function onTap;

  ServiceButton(
    this.title,
    this.assetIconPath,
    this.onTap, {
    this.iconScale = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 78,
            width: 78,
            decoration: BoxDecoration(
              color: kSecondaryGreenColor,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(width: 8, color: Color(0xffe4f2f2)),
            ),
            child: Transform.scale(
              scale: iconScale,
              child: ImageIcon(AssetImage(assetIconPath), color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          PrimaryText(title, Colors.grey[700], fontSize: 12, maxLines: 2, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
