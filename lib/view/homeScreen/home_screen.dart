import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/homeScreen/utils/working_hours_card.dart';
import '/view/utils/my_slider.dart';
import '../../core/presentation/values/app_colors.dart';
import '../../core/utils/locale_helper.dart';
import '../../states/getx_news_controller.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_text.dart';
import 'utils/language_dropdown_button.dart';
import 'utils/metrics_card.dart';
import 'utils/services_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'homePage_header'.tr,
          color: kPrimaryGreenColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 10),
              child: _LangDropDownBtnFutureBuilder(),
            ),
          ],
        ),
        backgroundColor: kAccentWhiteColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ServicesCard(),
                        SizedBox(height: 5),
                        _CampaignsCard(),
                        SizedBox(height: 5),
                        WorkingHoursCard(),
                        SizedBox(height: 5),
                        MetricsCard(),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CampaignsCard extends StatelessWidget {
  const _CampaignsCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Align(alignment: Alignment.centerLeft, child: _CustomTabBar()),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: () => Get.toNamed('/news'),
                    child: Text(
                      'homePage_newsSection_viewAll'.tr,
                      style: TextStyle(fontSize: 13, color: Color(0xff2d91e3)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TabBarView(children: [_SliderFuture(), _SliderFuture()]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderFuture extends StatelessWidget {
  const _SliderFuture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<GetxNewsController>(
      builder: (c) {
        if (c.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (c.homePageNews == null || c.homePageNews.isEmpty) {
          return Center(child: PrimaryText('News not found.', Colors.black, fontSize: 14));
        }

        List<Widget> images = c.homePageNews.getRange(0, 3).map((news) {
          return GestureDetector(
            onTap: () => Get.toNamed('/newsDetail', arguments: news),
            child: SizedBox(
              width: size.width * 0.7,
              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: news.image),
            ),
          );
        }).toList();

        return MySlider(images, size.height / 4.47, enlargeCenterPage: true);
      },
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.grey[800],
      indicatorColor: Colors.transparent,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(fontWeight: FontWeight.bold, /*fontFamily: 'Rotunda',*/ fontSize: 15),
      tabs: [
        Tab(text: 'homePage_newsSection_campaigns'.tr),
        Tab(text: 'homePage_newsSection_news'.tr),
      ],
    );
  }
}

class _LangDropDownBtnFutureBuilder extends StatefulWidget {
  const _LangDropDownBtnFutureBuilder({Key key}) : super(key: key);

  @override
  State<_LangDropDownBtnFutureBuilder> createState() => _LangDropDownBtnFutureBuilderState();
}

class _LangDropDownBtnFutureBuilderState extends State<_LangDropDownBtnFutureBuilder> {
  Future future;

  @override
  void initState() {
    super.initState();
    future = LocaleHelper.getUserSettingsLocale();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Locale>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String localeString = snapshot.data.toString();
            String languageCode = localeString.substring(0, 2).toUpperCase();

            return LanguageDropDownButton(languageCode);
          }

          return Container();
        },
      );
}
