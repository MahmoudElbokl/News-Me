import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_me/Models/news.dart';
import 'package:news_me/utilites.dart';

class NewsApi {
  Future<List<News>> fetchAllNews() async {
    List _allNews;
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

  Future<List> fetchTopicsNews(bool isRefresh) async {
    List _topicsNews;
    for (int i = 0; i < myTopics.length; i++) {
      String newsApiUrlForTopic =
          baseApiForCategory + topics[myTopics[i]["topicindex"]] + "&" + apiKey;
      var response = await http.get(newsApiUrlForTopic);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var articles = jsonData["articles"];
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
}
