import 'package:flutter/material.dart';
import 'package:news_me/Models/news_model.dart';
import 'package:news_me/controllers/news_fetcher.dart';

class NewsArticlesProvider with ChangeNotifier {
  NewsApi _newsApi = NewsApi();
  bool _isLoad = true;
  List<Article> _topicsNews = [];
  List<Article> _allNews = [];

  bool get isLoading {
    return _isLoad;
  }

  List<Article> get allNews {
    return [..._allNews];
  }

  List<Article> get topicsNews {
    return [..._topicsNews];
  }

  Future fetchAllNews() async {
    try {
      _isLoad = true;
      _allNews = await _newsApi.fetchAllNews();
      _isLoad = false;
    } catch (error) {
      _isLoad = false;
//      throw ("error");
    }
    notifyListeners();
  }

  Future fetchTopicsNews(bool isRefresh, String topic) async {
    try {
      _isLoad = true;

      _topicsNews = await _newsApi.fetchTopicsNews(isRefresh, topic);
      _isLoad = false;

//      _network = true;
    } catch (error) {
      _isLoad = false;
//      notifyListeners();
//      throw ("error");
    }
    notifyListeners();
  }
}
