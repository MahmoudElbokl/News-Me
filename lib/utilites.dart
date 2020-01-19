import 'package:flutter/material.dart';

String baseApi =
    "http://newsapi.org/v2/top-headlines?language=en&"; //topNews will add the api key only
String trending = "sortBy=popularity&";
String apiKey = "apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535";
String baseApiForCategory = "https://newsapi.org/v2/everything?q=";
String forCountry = "country=&";
String sources = "https://newsapi.org/v2/sources?";

// news for TopNews http://newsapi.org/v2/top-headlines?language=en&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535
// news for trending from http://newsapi.org/v2/top-headlines?language=en&sortBy=popularity&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535
// news for specific category https://newsapi.org/v2/everything?q=sports&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535
//business entertainment general health science sports technology
//news for specific Country https://newsapi.org/v2/top-headlines?country=us&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535
//news from specific source https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535
//for the search of the users https://newsapi.org/v2/everything?q=//"Will Add the search Parameter"&apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535

List<String> topics = [
  "general",
  "business",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology",
];

showErrorAlertDialog(String message, context) {
  showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
            message,
            style: Theme.of(context).textTheme.body1,
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Okay"),
            )
          ],
        );
      });
}
