import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:news_me/utilites.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';
import 'package:news_me/widgets/grid_view_articles.dart';
import 'package:news_me/widgets/horizontal_articles_scroll.dart';

class MyNews extends StatefulWidget {
  final statusBarSize;

  MyNews(this.statusBarSize);

  @override
  _MyNewsState createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  bool init = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (init) {
      final provider = Provider.of<NewsArticles>(context, listen: false);
      if (provider.topicsNews.length == 0 || NewsArticles.dpChanged) {
        await provider.fetchTopicsNews().catchError((error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorAlertDialog(
                "There are a connection error, Please check your internet Connection.",
                context);
          });
        });
        NewsArticles.dpChanged = false;
      }
    }
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<NewsArticles>(context).isLoading
        ? ShimmerList()
        : !Provider.of<NewsArticles>(context).network
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "You have a network connection error, Please check your connection",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Provider.of<NewsArticles>(context).topicsNews.length == 0
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
                            "Start choose your favorite Topics",
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
      showChildOpacityTransition: true,
      color: Provider
          .of<ThemeModel>(context)
          .currentTheme ==
          lightTheme
          ? Colors.red[100]
          : Colors.blueGrey,
      springAnimationDurationInMilliseconds: 300,
      onRefresh: () async {
        await Provider.of<NewsArticles>(context, listen: false)
            .fetchTopicsNews()
            .whenComplete(() {
          Future.value();
        }).catchError((error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.value();
            showErrorAlertDialog(
                "There are a connection error, Please check your internet Connection.",
                context);
          });
        });
      },
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height -
                (widget.statusBarSize + 100),
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
