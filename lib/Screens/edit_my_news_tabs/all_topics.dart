import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/expansion_item.dart';
import 'package:news_me/models/mynews_sources_provider.dart';
import 'package:news_me/utilites.dart';

class AllTopics extends StatefulWidget {
  @override
  _AllTopicsState createState() => _AllTopicsState();
}

class _AllTopicsState extends State<AllTopics> {
  bool isInit = true;
  Map<int, List<String>> mds = {};
  Map<int, int> mdsInt = {};

  @override
  void didChangeDependencies() async {
    final provider = Provider.of<MyNewsSources>(context, listen: false);
    super.didChangeDependencies();
    if (isInit) {
      for (int i = 0; i < topics.length; i++) {
        List<String> sourcesTopic = [];
        provider.newSources.forEach((source) {
          if (source.category == topics[i]) {
            sourcesTopic.add(source.name);
          }
        });
        mdsInt.putIfAbsent(i, () {
          return provider.checkCategoriesNumberOfSources(i, topics[i]);
        });
        mds.putIfAbsent(i, () {
          return sourcesTopic;
        });
      }
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyNewsSources>(context, listen: false);
    return Provider.of<MyNewsSources>(context).isLoading()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    provider.expandPanel(index);
                  },
                  children: provider.expansionPanelItems
                      .map<ExpansionPanel>((Item item) {
                    int itemValue = int.parse(item.expandedValue);
                    return ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          onTap: () {
                            item.isExpanded = !item.isExpanded;
                            provider.addTopicToActive(itemValue);
                          },
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            item.headerValue.toUpperCase(),
                            style: Theme.of(context).textTheme.body1,
                          ),
                          leading: Checkbox(
                              activeColor: Color(0xff329388),
                              value: provider.topicsActivity[itemValue],
                              onChanged: (newValue) {
                                provider.addTopicToActive(itemValue);
                              }),
                        );
                      },
                      body: Provider.of<MyNewsSources>(context).isLoading()
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : provider.newSources.length == 0
                              ? Center(
                                  child: Text(
                                      "Please Check Your internet connection"),
                                )
                              : SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          trailing:
                                              provider.topicsActivity[itemValue]
                                                  ? Icon(Icons.done,
                                                      color: Color(0xff329388))
                                                  : SizedBox.shrink(),
                                          title: Text(
                                            mds[itemValue][index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: mdsInt[itemValue],
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
