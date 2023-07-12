import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/utils/search_text_field.dart';
import '../../states/getx_polyclinics_controller.dart';
import '../utils/my_appbar.dart';
import 'utils/my_search_delegate.dart';
import 'utils/polyclinic_card.dart';

class PolyclinicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'polyclinicsPage_header'.tr, hasBackButton: true, height: 66),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 13),
            child: SearchTextField(
              hintText: 'polyclinicsPage_searchHint'.tr,
              onTap: () => showSearch(context: context, delegate: MySearchDelegate()),
            ),
          ),
          Expanded(
            child: GetBuilder<GetxPolyclinicsController>(
              builder: (c) {
                if (c.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (c.polyclinics == null || c.polyclinics.isEmpty) {
                  return const Center(child: Text('Poliklinik Bulunamadı.'));
                }

                return ListView.separated(
                  itemCount: c.polyclinics.length,
                  itemBuilder: (context, i) => PolyclinicCard(c.polyclinics[i]),
                  separatorBuilder: (c, i) => const SizedBox(height: 5),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
