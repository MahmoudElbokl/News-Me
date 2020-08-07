import 'package:news_me/Models/news_model.dart';
import 'package:news_me/services/api_helper.dart';

class NewsApi {
  ApiHelper apiProvider = ApiHelper();
  String apiKey = "apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535";

  fetchAllNews() async {
    final response = await apiProvider.get("top-headlines?language=en&$apiKey");
    return newsModelFromMap(response).articles;
  }

  fetchTopicsNews(bool isRefresh, String topic) async {
    var response;
    response = await apiProvider.get("everything?q=$topic&$apiKey");
    return newsModelFromMap(response).articles;
  }
}
