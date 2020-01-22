import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/providers/news_articles_provider.dart';
import 'package:news_me/providers/mynews_sources_provider.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Models/expansion_item.dart';
import 'package:news_me/utilites.dart';

class AllTopics extends StatefulWidget {
  @override
  _AllTopicsState createState() => _AllTopicsState();
}

class _AllTopicsState extends State<AllTopics> {
  bool isInit = true;

  changeTopicActivity(itemValue) {
    if (!EditMyNews.checkSelectionsChanges.contains(itemValue)) {
      EditMyNews.checkSelectionsChanges.add(itemValue);
    } else {
      EditMyNews.checkSelectionsChanges.remove(itemValue);
    }
    Provider.of<MyNewsSources>(context, listen: false)
        .addTopicToActive(itemValue);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      final provider = Provider.of<MyNewsSources>(context, listen: false);
      await Provider.of<NewsArticles>(context, listen: false)
          .fetchTopicFromDb();
      if (!provider.topicsActivity.contains(true)) {
        if (myTopics.length > 0) {
          for (int dpTopics = 0; dpTopics < myTopics.length; dpTopics++) {
            for (int topicIndex = 0; topicIndex < topics.length; topicIndex++) {
              if (myTopics[dpTopics]["topicindex"] == topicIndex) {
                await provider.addTopicToActive(topicIndex);
              }
            }
          }
        }
      }
      await provider.fetchAllSources();
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyNewsSources>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              provider.expandPanel(index);
            },
            children:
            provider.expansionPanelItems.map<ExpansionPanel>((Item item) {
              int itemValue = int.parse(item.expandedValue);
              return ExpansionPanel(
                isExpanded: item.isExpanded,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      item.headerValue.toUpperCase(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                    ),
                    onTap: () {
                      changeTopicActivity(itemValue);
                    },
                    leading: Checkbox(
                        activeColor: Colors.red[400],
                        value: provider.topicsActivity[itemValue],
                        onChanged: (newValue) {
                          changeTopicActivity(itemValue);
                        }),
                  );
                },
                body: Provider.of<MyNewsSources>(context).isLoading()
                    ? Center(
                  child: LinearProgressIndicator(),
                )
                    : provider.newSources.length == 0
                    ? Center(
                  child:
                  Text("Please Check Your internet connection"),
                )
                    : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: provider.topicsActivity[itemValue]
                              ? Icon(Icons.done,
                              color: Colors.red[400])
                              : SizedBox.shrink(),
                          title: Text(
                            "- ${provider.topicSources[itemValue][index]}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount:
                      provider.topicSources[itemValue].length,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
