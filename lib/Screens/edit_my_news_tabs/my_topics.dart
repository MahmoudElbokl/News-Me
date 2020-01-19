import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/models/mynews_sources_provider.dart';

class MyTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyNewsSources>(context, listen: false);
    return provider.activeTopics.length == 0
        ? Center(
            child: Text("Your added topics will be displayed here"),
          )
        : Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    title: Text(
                      provider.activeTopics[index].toUpperCase(),
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                );
              },
              itemCount: provider.numberOfActive,
            ),
          );
  }
}
