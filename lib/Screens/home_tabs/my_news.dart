import 'package:flutter/material.dart';
import 'package:news_me/utilites.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';
import 'package:news_me/widgets/grid_view_articles.dart';
import 'package:news_me/widgets/horizontal_articles_scroll.dart';

class MyNews extends StatefulWidget {
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
                          child: Text("Start choose your favorite Topics"),
                          color: Color(0xff329388),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: <Widget>[
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? SizedBox.shrink()
                          : HorizontalArticlesScroll(),
                      Expanded(
                        child: GridViewArticles(),
                      ),
                    ],
                  );
  }
}
