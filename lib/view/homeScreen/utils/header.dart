import 'package:flutter/material.dart';

import '../../utils/primary_text.dart';

class Header extends StatelessWidget {
  final String title;
  final Function seeAllOnTapped;

  Header(this.title, this.seeAllOnTapped);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Title
          PrimaryText(
            title,
            Colors.grey[800],
            fontSize: 15,
          ),
          //Tümünü Gör
          GestureDetector(
            onTap: seeAllOnTapped,
            child: Text(
              'Tümünü Göster',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff2d91e3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
