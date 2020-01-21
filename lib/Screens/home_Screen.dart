import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Screens/home_tabs/WhatsNew.dart';
import 'package:news_me/Screens/home_tabs/my_news.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Models/news.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<News> trending;
  IconButton icon;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: NewsArticles.tabIndex, length: 2, vsync: this);
    _tabController.addListener(_handleTab);
    NewsArticles.tabIndex = 0;
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

//  @override
//  void didChangeDependencies() async {
//    super.didChangeDependencies();
//    if (isInit) {
//      final provider = Provider.of<NewsArticles>(context, listen: false);
//      if (provider.allNews.length == 0) {
//        topNews = await provider.fetchAllNews().catchError((error) {
//          WidgetsBinding.instance.addPostFrameCallback((_) {
//            showErrorAlertDialog(
//                "Please check your internet connection", context);
//          });
//        });
//      } else {
//        topNews = provider.allNews;
//      }
//    }
//    isInit = false;
//  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTab);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery
        .of(context)
        .padding
        .top;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: (context),
          child: AlertDialog(
            title: new Text('Do you want to exit this application?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: MainScaffold(
          navigationDrawer: true,
          title: "Explore",
          actions: _tabController.index == 1
              ? IconButton(
              icon: Icon(Icons.edit),
              tooltip: "Edit my news",
              onPressed: () {
                Navigator.of(context).pushNamed(EditMyNews.routeName);
              })
              : icon,
          tabBar: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "What’s Now"),
              Tab(text: "My News"),
            ],
            controller: _tabController,
          ),
          body: TabBarView(
            children: [
              WhatsNew(statusBar),
              MyNews(statusBar),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
