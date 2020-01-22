import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/widgets/all_topics.dart';
import 'package:news_me/providers/mynews_sources_provider.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';
import 'package:news_me/utilites.dart';

class EditMyNews extends StatelessWidget {
  static List<int> checkSelectionsChanges = [];
  static String routeName = "edit_my_news";

  cancelChanges(context) {
    Provider.of<MyNewsSources>(context, listen: false).returnActiveToFalse();
    Provider.of<MyNewsSources>(context, listen: false).returnExpansionToFalse();
    for (int i = 0; i < myTopics.length; i++) {
      Provider.of<MyNewsSources>(context, listen: false).addTopicToActive(
        topics.indexOf(topics[myTopics[i]["topicindex"]]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (EditMyNews.checkSelectionsChanges.length > 0) {
          EditMyNews.checkSelectionsChanges = [];
          return showDialog(
              context: context,
              child: AlertDialog(
                title: Text("Are you want to exit with unsave Changes?"),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      cancelChanges(context);
                      return Navigator.of(context).pop(true);
                    },
                    child: new Text('Yes'),
                  )
                ],
              ));
        } else {
          cancelChanges(context);
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
                  dpChanged = false;
                }
                Provider.of<MyNewsSources>(context, listen: false)
                    .returnExpansionToFalse();
                tabIndex = 1;
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              }),
          title: "My News Topics",
          body: AllTopics()),
    );
  }
}
