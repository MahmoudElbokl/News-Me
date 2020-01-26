import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_me/Models/news.dart';
import 'package:news_me/Models/news_sources.dart';
import 'package:news_me/utilites.dart';

class NewsApi {
  fetchAllNews() async {
    List _allNews = [];
    String newsApiUrl = baseApi + apiKey;
    var response = await http.get(newsApiUrl);
    Map<String, dynamic> jsonData = await jsonDecode(response.body);
    var articles = await jsonData["articles"];
    for (var item in articles) {
      final source = item["source"];
      final String title = item["title"];
      if (title != null &&
          title.length > 5 &&
          (item["description"] != null || item["content"] != null) &&
          item["publishedAt"] != null) {
        News article = News(
          source: Source(source["id"], source["name"]),
          author: item["author"],
          title: title,
          description: item["description"],
          content: item["content"],
          publishedAt: item["publishedAt"],
          url: item["url"],
          urlToImage: item["urlToImage"],
        );
        if (!_allNews.contains(article.title)) {
          _allNews.add(article);
        }
      }
    }
    return _allNews;
  }

  fetchTopicsNews(bool isRefresh) async {
    List _topicsNews = [];
    for (int i = 0; i < myTopics.length; i++) {
      String newsApiUrlForTopic =
          baseApiForCategory + topics[myTopics[i]["topicindex"]] + "&" + apiKey;
      var response = await http.get(newsApiUrlForTopic);
      Map<String, dynamic> jsonData = await jsonDecode(response.body);
      var articles = await jsonData["articles"];
      for (var item in articles) {
        final source = item["source"];
        if (item["title"] != null ||
            item["description"] != null ||
            item["content"] != null ||
            item["urlToImage"] != null ||
            item["publishedAt"] != null) {
          News article = News(
            source: Source(source["id"], source["name"]),
            author: item["author"],
            title: item["title"],
            description: item["description"],
            content: item["content"],
            publishedAt: item["publishedAt"],
            url: item["url"],
            urlToImage: item["urlToImage"],
          );
          if (!_topicsNews.contains(article.title)) {
            _topicsNews.add(article);
          }
        }
      }
    }
    return _topicsNews;
  }

  Future fetchAllSources() async {
    String sourcesApi = sources + apiKey;
    var response = await http.get(sourcesApi);
    List<NewsSources> _newsSources = [];
//    if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    var allSources = jsonData["sources"];
    for (var item in allSources) {
      _newsSources.add(
        NewsSources(
          id: item["id"],
          name: item["name"],
          category: item["category"],
        ),
      );
    }
    return _newsSources;
//    } else {
//      _isLoad = false;
//      throw ("error");
//    }
//    for (int i = 0; i < topics.length; i++) {
//      List<String> sourcesTopic = [];
//      _newsSources.forEach((source) {
//        if (source.category == topics[i]) {
//          sourcesTopic.add(source.name);
//        }
//      });
//      _eachTopicSources.putIfAbsent(i, () {
//        return sourcesTopic;
//      });
//    }
//    _isLoad = false;
//    notifyListeners();
  }
}
