import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/polyclinic.dart';
import '../../utils/primary_text.dart';

class PolyclinicCard extends StatelessWidget {
  const PolyclinicCard(this.polyclinicModel);

  final PolyclinicModel polyclinicModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Get.toNamed('/polyclinicDetail', arguments: polyclinicModel),
      child: Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 12, top: 24, bottom: 24),
              child: SizedBox(
                width: size.width * 0.2,
                height: size.width * 0.2,
                child: ClipRRect(
                  child: polyclinicModel.image,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Polyclinic name
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    polyclinicModel.title,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      /*fontFamily: 'Rotunda',*/ fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                //Polyclinic description
                SizedBox(
                  width: size.width * 0.6,
                  child: PrimaryText(
                    polyclinicModel.description,
                    Colors.grey,
                    fontSize: 14,
                    maxLines: 3,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
