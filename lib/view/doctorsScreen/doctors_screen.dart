import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/controller/doctor.dart';
import '/models/doctor.dart';
import '/view/utils/doctor_card.dart';
import '/view/utils/search_text_field.dart';
import '../../states/getx_doctors_controller.dart';
import '../utils/my_appbar.dart';
import 'utils/my_search_delegate.dart';

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'doctorsPage_header'.tr,
        hasBackButton: true,
        height: 66,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({Key key}) : super(key: key);

  final GetxDoctorsController _getxDoctorsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 13),
            child: SearchTextField(
              hintText: 'doctorsPage_searchHint'.tr,
              onTap: () => showSearch(context: context, delegate: MySearchDelegate()),
            ),
          ),
          Expanded(child: const _DoctorsListView()),
        ],
      ),
    );
  }
}

class _DoctorsListView extends StatefulWidget {
  const _DoctorsListView({Key key}) : super(key: key);

  @override
  __DoctorsListViewState createState() => __DoctorsListViewState();
}

class __DoctorsListViewState extends State<_DoctorsListView> {
  final PagingController<int, DoctorModel> _pagingController = PagingController(firstPageKey: 1);

  static const _pageSize = 10;

  @override
  void initState() {
    _pagingController.addPageRequestListener((page) => _fetchPage(page));
    super.initState();
  }

  Future<void> _fetchPage(int page) async {
    try {
      final newDoctors = await DoctorController.fetchDoctors(page);
      final isLastPage = newDoctors.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newDoctors);

        print('LAST PAGE ACHIEVED.');
      } else {
        final nextPageKey = page + 1;

        _pagingController.appendPage(newDoctors, nextPageKey);

        print('PAGEKEY: $page');
      }
    } catch (error) {
      _pagingController.error = error;
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, DoctorModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<DoctorModel>(
          itemBuilder: (context, doctor, index) => DoctorCard(doctor),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
