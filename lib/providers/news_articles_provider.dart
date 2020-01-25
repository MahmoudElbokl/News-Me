import 'package:flutter/material.dart';

import 'package:news_me/Models/news.dart';
import 'package:news_me/my_news_db.dart';
import 'package:news_me/services/news_api.dart';
import 'package:news_me/utilites.dart';

class NewsArticles with ChangeNotifier {
  NewsApi _newsApi = NewsApi();
  bool _isLoad = true;
  MyNewsTopicsDb _db = MyNewsTopicsDb();
  List<News> _topicsNews = List<News>();
  List<News> _allNews = List<News>();
  bool _network = true;

  bool get isLoading {
    return _isLoad;
  }

  bool get network {
    return _network;
  }

  setNetwork(bool network) {
    _network = network;
    notifyListeners();
  }

  setLoad(bool loading) {
    _isLoad = loading;
    notifyListeners();
  }

  List<News> get allNews {
    return [..._allNews];
  }

  List<News> get topicsNews {
    return [..._topicsNews];
  }

  Future<List<News>> fetchAllNews() async {
    try {
      _isLoad = true;
      _allNews = await _newsApi.fetchAllNews();
      _network = true;
      _isLoad = false;
    } catch (error) {
      _isLoad = false;
      _network = false;
      notifyListeners();
      throw ("error");
    }
    notifyListeners();
    return _allNews;
  }

//  Future<List<News>> fetchAllNews() async {
//    _isLoad = true;
//    String newsApiUrl = baseApi + apiKey;
//    var response = await http.get(newsApiUrl);
//    if (response.statusCode == 200) {
//      _network = true;
//      Map<String, dynamic> jsonData = await jsonDecode(response.body);
//      var articles = await jsonData["articles"];
//      for (var item in articles) {
//        final source = item["source"];
//        final String title = item["title"];
//        if (title != null &&
//            title.length > 5 &&
//            (item["description"] != null || item["content"] != null) &&
//            item["publishedAt"] != null) {
//          News article = News(
//            source: Source(source["id"], source["name"]),
//            author: item["author"],
//            title: title,
//            description: item["description"],
//            content: item["content"],
//            publishedAt: item["publishedAt"],
//            url: item["url"],
//            urlToImage: item["urlToImage"],
//          );
//          if (!_allNews.contains(article.title)) {
//            _allNews.add(article);
//          }
//        }
//      }
//    } else {
//      _isLoad = false;
//      _network = false;
//      notifyListeners();
//      throw ("error");
//    }
//    _isLoad = false;
//    _network = true;
//    notifyListeners();
//    return _allNews;
//  }

  Future<List> fetchTopicFromDb() async {
    myTopics = await _db.getAllSavedTopics();
    return myTopics;
  }

  Future<void> fetchTopicsNews(bool isRefresh) async {
    try {
      _isLoad = true;
      await fetchTopicFromDb();
      if (myTopics.length != 0 || isRefresh) {
        if (!isRefresh) {
          _topicsNews = [];
        }
        _topicsNews = await _newsApi.fetchTopicsNews(isRefresh);
        _network = true;
        _isLoad = false;
      } else {
        _topicsNews = [];
        _isLoad = false;
        _network = true;
        notifyListeners();
      }
      _network = true;
    } catch (error) {
      _isLoad = false;
      _network = false;
      notifyListeners();
      throw ("error");
    }
  }

//  Future<void> fetchTopicsNews(bool isRefresh) async {
//    _isLoad = true;
//    await fetchTopicFromDb();
//    if (myTopics.length != 0 || isRefresh) {
//      if (!isRefresh) {
//        _topicsNews = [];
//      }
//      for (int i = 0; i < myTopics.length; i++) {
//        String newsApiUrlForTopic = baseApiForCategory +
//            topics[myTopics[i]["topicindex"]] +
//            "&" +
//            apiKey;
//        var response = await http.get(newsApiUrlForTopic);
//        if (response.statusCode == 200) {
//          Map<String, dynamic> jsonData = jsonDecode(response.body);
//          var articles = jsonData["articles"];
//          for (var item in articles) {
//            final source = item["source"];
//            if (item["title"] != null ||
//                item["description"] != null ||
//                item["content"] != null ||
//                item["urlToImage"] != null ||
//                item["publishedAt"] != null) {
//              News article = News(
//                source: Source(source["id"], source["name"]),
//                author: item["author"],
//                title: item["title"],
//                description: item["description"],
//                content: item["content"],
//                publishedAt: item["publishedAt"],
//                url: item["url"],
//                urlToImage: item["urlToImage"],
//              );
//              if (!_allNews.contains(article.title)) {
//                _topicsNews.add(article);
//              }
//            }
//          }
//        } else {
//          _isLoad = false;
//          _network = false;
//          notifyListeners();
//          throw ("error");
//        }
//      }
//      _network = true;
//    } else {
//      _network = true;
//      _topicsNews = [];
//    }
//    _isLoad = false;
//    notifyListeners();
//  }
}