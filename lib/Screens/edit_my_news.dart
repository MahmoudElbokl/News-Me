import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/Screens/edit_my_news_tabs/all_topics.dart';
import 'package:news_me/Screens/edit_my_news_tabs/my_topics.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/models/mynews_sources_provider.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';
import 'package:news_me/utilites.dart';

class EditMyNews extends StatefulWidget {
  static String routeName = "edit_my_news";

  @override
  _EditMyNewsState createState() => _EditMyNewsState();
}

class _EditMyNewsState extends State<EditMyNews> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<MyNewsSources>(context, listen: false);
      await Provider.of<NewsArticles>(context, listen: false)
          .fetchTopicFromDb();
      if (!provider.topicsActivity.contains(true)) {
        if (NewsArticles.myTopics.length > 0) {
          for (int dpTopics = 0;
              dpTopics < NewsArticles.myTopics.length;
              dpTopics++) {
            for (int topicIndex = 0; topicIndex < topics.length; topicIndex++) {
              if (NewsArticles.myTopics[dpTopics]["topicindex"] == topicIndex) {
                await provider.addTopicToActive(topicIndex);
              }
            }
          }
        }
      }
      await provider.fetchAllSources();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MainScaffold(
        actions: IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Provider.of<MyNewsSources>(context, listen: false)
                  .saveOnDataBase();
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }),
        tabBar: TabBar(
          tabs: [
            Tab(
              text: "My Topics",
            ),
            Tab(
              text: "Add Topic",
            ),
          ],
          indicatorColor: Colors.white,
        ),
        title: "Edit My News",
        body: Provider.of<NewsArticles>(context).network
            ? Provider.of<MyNewsSources>(context).isLoading()
                ? ShimmerList()
                : TabBarView(
                    children: [
                      MyTopics(),
                      AllTopics(),
                    ],
                  )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      "You have a network connection error, Please check your connection"),
                ),
              ),
      ),
    );
  }
}
