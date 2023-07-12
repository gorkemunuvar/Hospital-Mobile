import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/view/utils/news_card.dart';
import '../../controller/news.dart';
import '../../models/news.dart';
import '../../states/getx_base_states.dart';
import '../../states/getx_news_controller.dart';
import '../utils/my_appbar.dart';
import '../utils/primary_text.dart';

class NewsScreen extends StatelessWidget {
  final getxNewsController = Get.put(GetxNewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'newsPage_header'.tr, hasBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: const _NewsListView(),
        ),
      ),
    );
  }
}

class _NewsListView extends StatefulWidget {
  const _NewsListView({Key key}) : super(key: key);

  @override
  __NewsListViewState createState() => __NewsListViewState();
}

class __NewsListViewState extends State<_NewsListView> {
  final GetXBaseStates _baseStates = Get.find();
  final PagingController<int, NewsModel> _pagingController = PagingController(firstPageKey: 1);

  static const _pageSize = 10;

  @override
  void initState() {
    _pagingController.addPageRequestListener((page) => _fetchPage(page));
    super.initState();
  }

  Future<void> _fetchPage(int page) async {
    try {
      final newNews = await NewsController.fetchNews(page, _baseStates.lang);
      final isLastPage = newNews.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newNews);
      } else {
        final nextPageKey = page + 1;
        _pagingController.appendPage(newNews, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, NewsModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NewsModel>(
          itemBuilder: (context, news, index) => NewsCard(news),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
