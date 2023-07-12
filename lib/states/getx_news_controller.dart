import 'package:get/get.dart';

import '/controller/news.dart';
import '/models/news.dart';
import 'getx_base_states.dart';

class GetxNewsController extends GetxController {
  final GetXBaseStates _baseStates = Get.find();

  bool isLoading = true;
  List<NewsModel> homePageNews = [];

  @override
  void onInit() {
    super.onInit();
    fetchHomePageNews();
  }

  Future<void> fetchHomePageNews() async {
    isLoading = true;
    homePageNews = await NewsController.fetchHomePageNews(_baseStates.lang);
    isLoading = false;

    update();
  }
}
