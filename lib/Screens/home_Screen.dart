import 'package:flutter/material.dart';
import 'package:news_me/utilites.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Screens/home_tabs/WhatsNew.dart';
import 'package:news_me/Screens/home_tabs/my_news.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Models/news.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<News> trending;
  List<News> topNews = [];
  bool isInit = true;
  IconButton icon;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(_handleTab);
  }

  _handleTab() {
    if (_tabController.index == 1) {
      setState(() {
        icon = IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Edit my news",
            onPressed: () {
              Navigator.of(context).pushNamed(EditMyNews.routeName);
            });
      });
    } else {
      setState(() {
        icon = null;
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      final provider = Provider.of<NewsArticles>(context, listen: false);
      if (provider.allNews.length == 0) {
        topNews = await provider.fetchAllNews().catchError((error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorAlertDialog(
                "Please check your internet connection", context);
          });
        });
      } else {
        topNews = provider.allNews;
      }
    }
    isInit = false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsArticles>(context);
    return MainScaffold(
      navigationDrawer: true,
      title: "Explore",
      actions: icon,
      tabBar: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(text: "What’s Now"),
          Tab(text: "My News"),
        ],
        controller: _tabController,
      ),
      body: provider.network
          ? provider.isLoading
              ? ShimmerList()
              : TabBarView(
                  children: [
                    WhatsNew(topNews),
                    MyNews(),
                  ],
                  controller: _tabController,
                )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    "You have a network connection error, Please check your connection"),
              ),
            ),
    );
  }
}
