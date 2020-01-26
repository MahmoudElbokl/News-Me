import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news_me/providers/theme_changer_provider.dart';
import 'package:news_me/utilites.dart';
import 'package:provider/provider.dart';

import 'package:news_me/providers/news_articles_provider.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/widgets/mynews_grid_view.dart';
import 'package:news_me/widgets/mynews_horizontal_articles.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';

class MyNews extends StatefulWidget {
  final statusBarSize;

  MyNews(this.statusBarSize);

  @override
  _MyNewsState createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  bool init = true;

  _onRefresh() async {
    final provider = Provider.of<NewsArticles>(context, listen: false);
    await provider.fetchTopicsNews(true);

//    .catchError((error) {
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        provider.setNetwork(false);
//        provider.setLoad(false);
//        Future.value();
//      });
//    });
//    Future.delayed(Duration(seconds: 30),);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (init) {
      final provider = Provider.of<NewsArticles>(context, listen: false);
      if (provider.topicsNews.length == 0 || dpChanged) {
        await provider.fetchTopicsNews(false);
//        .catchError((error) {
//          print("43");
//          WidgetsBinding.instance.addPostFrameCallback((_) {
//            provider.setNetwork(false);
//            provider.setLoad(false);
//          });
//        });
        dpChanged = false;
      }
    }
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsArticles>(context);
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final pullToRefreshColor =
    Provider
        .of<ThemeModel>(context, listen: false)
        .currentTheme ==
        lightTheme
        ? Colors.red[100]
        : Colors.blueGrey;
    return provider.isLoading
        ? ShimmerList()
        : !provider.network
        ? LiquidPullToRefresh(
      showChildOpacityTransition: true,
      color: pullToRefreshColor,
      springAnimationDurationInMilliseconds: 300,
      onRefresh: () async {
        return _onRefresh();
      },
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: (height * 0.5 - 100 - widget.statusBarSize)),
            child: Text(
              "You have a network connection error, Please check your connection",
              textAlign: TextAlign.center,
            ),
          )
        ],
                ),
              )
        : provider.topicsNews.length == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "All the latest stories from your choosen topics will apear here.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(EditMyNews.routeName);
                          },
                          child: Text(
                            "Start choose your Topics",
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.white),
                          ),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
        : LiquidPullToRefresh(
      color: pullToRefreshColor,
      springAnimationDurationInMilliseconds: 300,
      onRefresh: () async {
        return _onRefresh();
      },
      child: ListView(
        children: <Widget>[
          Container(
            height: height - (widget.statusBarSize + 100),
            child: Column(
              children: <Widget>[
                MediaQuery
                    .of(context)
                    .orientation ==
                    Orientation.landscape
                    ? SizedBox.shrink()
                    : HorizontalArticlesScroll(),
                Expanded(
                  child: GridViewArticles(),
                ),
              ],
            ),
          ),
        ],
      ),
                  );
  }
}
