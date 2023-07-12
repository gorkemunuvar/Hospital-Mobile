import 'package:flutter/material.dart';

import '../../../core/presentation/values/app_colors.dart';
import '../../utils/primary_text.dart';

class MetricInfo extends StatelessWidget {
  final String iconPath;
  final double iconScale;
  final String number;
  final String infoTitle;

  MetricInfo(this.iconPath, this.number, this.infoTitle, {this.iconScale = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //Icon
          Container(
            height: 55,
            width: 55,
            child: Transform.scale(
              scale: iconScale,
              child: ImageIcon(
                AssetImage(iconPath),
                color: kPrimaryGreenColor,
              ),
            ),
          ),
          SizedBox(height: 5),
          //Number
          PrimaryText(number, Colors.grey[700], fontSize: 18),
          //Info
          PrimaryText(infoTitle, Colors.grey[700], fontSize: 12),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
