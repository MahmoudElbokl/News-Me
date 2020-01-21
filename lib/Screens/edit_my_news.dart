import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/Screens/edit_my_news_tabs/all_topics.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/models/mynews_sources_provider.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';
import 'package:news_me/utilites.dart';

class EditMyNews extends StatelessWidget {
  static List<int> checkSelectionsChanges = [];
  static String routeName = "edit_my_news";


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (EditMyNews.checkSelectionsChanges.length > 0) {
          EditMyNews.checkSelectionsChanges = [];
          return showDialog(
              context: context,
              child: AlertDialog(
                title: Text("Are you want to unsave Changes?"),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Provider.of<MyNewsSources>(context, listen: false)
                          .returnActiveToFalse();
                      Provider.of<MyNewsSources>(context, listen: false)
                          .returnExpansionToFalse();
                      for (int i = 0; i < NewsArticles.myTopics.length; i++) {
                        Provider.of<MyNewsSources>(context, listen: false)
                            .addTopicToActive(
                          topics.indexOf(
                              topics[NewsArticles.myTopics[i]["topicindex"]]),
                        );
                      }
                      return Navigator.of(context).pop(true);
                    },
                    child: new Text('Yes'),
                  )
                ],
              ));
        } else {
          Provider.of<MyNewsSources>(context, listen: false)
              .returnActiveToFalse();
          Provider.of<MyNewsSources>(context, listen: false)
              .returnExpansionToFalse();
          for (int i = 0; i < NewsArticles.myTopics.length; i++) {
            Provider.of<MyNewsSources>(context, listen: false).addTopicToActive(
              topics.indexOf(topics[NewsArticles.myTopics[i]["topicindex"]]),
            );
          }
          return Future.value(true);
        }
      },
      child: MainScaffold(
          actions: IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                if (EditMyNews.checkSelectionsChanges.length > 0) {
                  EditMyNews.checkSelectionsChanges = [];
                  await Provider.of<MyNewsSources>(context, listen: false)
                      .saveOnDataBase();
                } else {
                  NewsArticles.dpChanged = false;
                }
                Provider.of<MyNewsSources>(context, listen: false)
                    .returnExpansionToFalse();
                NewsArticles.tabIndex = 1;
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              }),
          title: "My News Topics",
          body:
          AllTopics()
      ),
    );
  }
}
