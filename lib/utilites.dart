import 'package:flutter/material.dart';

String baseApi = "http://newsapi.org/v2/top-headlines?language=en&";
String apiKey = "apiKey=7f6b8a4ee3f24ad8a969d59ab6b4b535";
String baseApiForCategory = "https://newsapi.org/v2/everything?q=";
String sources = "https://newsapi.org/v2/sources?";

List<String> topics = [
  "general",
  "business",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology",
];

int tabIndex = 0;
List myTopics = [];
bool dpChanged = false;

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
