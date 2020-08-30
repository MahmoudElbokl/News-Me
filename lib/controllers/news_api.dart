import 'package:news_me/Models/news_model.dart';
import 'package:news_me/services/api_helper.dart';
import 'package:news_me/services/response_classify.dart';

import '../Models/news_model.dart';

class NewsApi {
  ApiHelper apiProvider = ApiHelper();
  String apiKey = "apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535";

  Future<ResponseClassify<List<Article>>> fetchAllNews(int page) async {
    final response =
        await apiProvider.get("top-headlines?language=en&page=$page&$apiKey");
    return ResponseClassify.completed(newsModelFromMap(response).articles);
  }

  Future<ResponseClassify<List<Article>>> fetchTopicsNews(
      bool isRefresh, String topic) async {
    var response;
    response = await apiProvider.get("everything?q=$topic&$apiKey");
    return ResponseClassify.completed(newsModelFromMap(response).articles);
  }
}
