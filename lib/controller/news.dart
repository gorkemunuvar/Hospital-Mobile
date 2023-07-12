import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/news.dart';
import '../core/config/app_constants.dart';
import '../core/enums/enums.dart';

class NewsController {
  static String _url = '$ngrok/news';

  static Future<List<NewsModel>> fetchNews(int page, [Lang lang = Lang.ru]) async {
    List<NewsModel> news = [];
    final _lang = lang == Lang.kk ? 'kk' : 'ru';
    final query = _url + '/$page?lang=${_lang.trim()}';

    news = await _fetchNews(query);
    return news;
  }

  static Future<List<NewsModel>> fetchHomePageNews([Lang lang = Lang.ru]) async {
    List<NewsModel> news = [];
    final _lang = lang == Lang.kk ? 'kk' : 'ru';
    final query = _url + '/home-page?lang=${_lang.trim()}';

    news = await _fetchNews(query);
    return news;
  }

  static Future<List<NewsModel>> _fetchNews(String query) async {
    List<NewsModel> news = [];
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.get(Uri.parse(query), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)['news'] as List;
        news = jsonList.map((json) => NewsModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
    }

    return news;
  }
}
