import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_me/Models/news_articles_provider.dart';
import 'dart:convert';
import 'package:queries/collections.dart';

import 'package:news_me/Models/expansion_item.dart';
import 'package:news_me/Models/news_sources.dart';
import 'package:news_me/my_news_db.dart';
import 'package:news_me/utilites.dart';

class MyNewsSources with ChangeNotifier {
  MyNewsTopicsDb _db = MyNewsTopicsDb();
  bool _isLoad = true;
  List<NewsSources> _newsSources = [];

  List<Item> _expansionPanelItems = List.generate(topics.length, (index) {
    return Item(
      headerValue: topics[index],
      expandedValue: index.toString(),
    );
  });

  List<bool> _topicsActivity = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  isLoading() {
    return _isLoad;
  }

  List<NewsSources> get newSources {
    return [..._newsSources];
  }

  List<Item> get expansionPanelItems {
    return _expansionPanelItems;
  }

  returnExpansionToFalse() {
    _expansionPanelItems = List.generate(topics.length, (index) {
      return Item(
        headerValue: topics[index],
        expandedValue: index.toString(),
      );
    });
  }

  expandPanel(index) {
    _expansionPanelItems[index].isExpanded =
        !_expansionPanelItems[index].isExpanded;
    notifyListeners();
  }

  fetchAllSources() async {
    _isLoad = true;
    if (_newsSources.length > 0) {
      _isLoad = false;
      notifyListeners();
    } else {
      String sourcesApi = sources + apiKey;
      final response = await http.get(sourcesApi);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var allSources = jsonData["sources"];
        for (var item in allSources) {
          _newsSources.add(
            NewsSources(
              id: item["id"],
              name: item["name"],
              category: item["category"],
            ),
          );
        }
      } else {
        _isLoad = false;
        throw ("error");
      }
      _isLoad = false;
      notifyListeners();
    }
  }

  int checkCategoriesNumberOfSources(sourceIndex, category) {
    return Collection(_newsSources).count((item) {
      return item.category == category;
    });
  }

  int get numberOfActive {
    int i = 0;
    _topicsActivity.forEach((value) {
      if (value == true) {
        i++;
      }
    });
    return i;
  }

  List<String> get activeTopics {
    List<String> active = [];
    int i = -1;
    _topicsActivity.forEach((value) {
      i++;
      if (value == true) {
        active.add(topics[i]);
      }
    });
    return active;
  }

  saveOnDataBase() {
    NewsArticles.dpChanged = true;
    _db.deleteTable();
    int i = -1;
    _topicsActivity.forEach((value) {
      i++;
      if (value == true) {
        _db.saveTopic(i);
      }
    });
    _isLoad = true;
    _topicsActivity = List.generate(topics.length, (index) {
      return false;
    });
  }

  List<bool> get topicsActivity {
    return [..._topicsActivity];
  }

  returnActiveToFalse() {
    _topicsActivity = List.generate(topics.length, (index) {
      return false;
    });
  }

  addTopicToActive(topicIndex) {
    _topicsActivity[topicIndex] = !_topicsActivity[topicIndex];
    notifyListeners();
  }
}
