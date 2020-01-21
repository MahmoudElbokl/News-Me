import 'package:flutter/material.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';
import 'package:news_me/utilites.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:news_me/Models/news.dart';
import 'package:news_me/Screens/article_details_screen.dart';

class WhatsNew extends StatefulWidget {
  final statusBarSize;

  WhatsNew(this.statusBarSize);

  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  bool isInit = true;
  List<News> news = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      final provider = Provider.of<NewsArticles>(context, listen: false);
      if (provider.allNews.length == 0) {
        news = await provider.fetchAllNews().catchError((error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setNetwork(false);
            provider.setLoad(false);
          });
        });
      } else {
        news = provider.allNews;
      }
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery
        .of(context)
        .orientation;
    final double height = size.height;

    return Provider
        .of<NewsArticles>(context)
        .isLoading
        ? ShimmerList()
        : Provider
        .of<NewsArticles>(context)
        .network
        ? LiquidPullToRefresh(
        color:
        Provider
            .of<ThemeModel>(context)
            .currentTheme == lightTheme
            ? Colors.red[100]
            : Colors.blueGrey,
        onRefresh: () async {
          news = await Provider.of<NewsArticles>(context, listen: false)
              .fetchAllNews()
              .whenComplete(() {
            return Future.value();
          }).catchError((error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.value();
              showErrorAlertDialog(
                  "Please check your internet connection", context);
            });
          });
        },
        springAnimationDurationInMilliseconds: 300,
        child: ListView.builder(
          itemCount: news.length > 16 ? 17 : news.length,
          itemBuilder: (context, index) {
            if (news[index].title == news[index + 1].title) {
              return SizedBox.shrink();
            }
            if (index == 0) {
              return orientation != Orientation.landscape
                  ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, ArticleDetails.routeName,
                      arguments: news[index]);
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height:
                  MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: news[0].urlToImage == null
                            ? AssetImage(
                            "assets/images/news-placeholder.png")
                            : NetworkImage(news[0].urlToImage),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Text(
                            "${news[0].title}",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme
                                .of(context)
                                .textTheme
                                .body2
                                .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: height > 700 ? 18 : 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                news[0].source.name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(fontSize: height > 700 ? 14 : 10),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    formatTime(DateTime
                                        .parse(
                                        news[0].publishedAt)
                                        .millisecondsSinceEpoch),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(
                                        fontSize: height > 700 ? 14 : 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
                  : SizedBox.shrink();
            }
            if (index == 1) {
              return orientation != Orientation.landscape
                  ? Container(
                color: Provider
                    .of<ThemeModel>(context)
                    .currentTheme ==
                    darkTheme
                    ? Colors.grey[850]
                    : Colors.grey[830],
                padding: const EdgeInsets.only(left: 10, top: 5),
                width: double.infinity,
                child: Text("Top Stories",
                    style: TextStyle(
                      fontSize: height > 700 ? 18 : 16,
                    )),
              )
                  : SizedBox.shrink();
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ArticleDetails.routeName,
                      arguments: news[index +
                          (orientation == Orientation.landscape
                              ? 0
                              : 1)]);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Card(
                    child: Container(
//                                  padding: const EdgeInsets.only(
//                                      right: 15, left: 10, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: size.height *
                                  ((orientation == Orientation.landscape
                                      ? 0.25
                                      : 0.15)),
                              width: size.width * 0.3,
                              child: news[index +
                                  (orientation ==
                                      Orientation
                                          .landscape
                                      ? 0
                                      : 1)]
                                  .urlToImage ==
                                  null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft:
                                    Radius.circular(4)),
                                child: Image.asset(
                                    "assets/images/news-placeholder.png"),
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft:
                                    Radius.circular(4)),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage(
                                      "assets/images/news-placeholder.png"),
                                  image: NetworkImage(
                                    news[index +
                                        (orientation ==
                                            Orientation
                                                .landscape
                                            ? 0
                                            : 1)]
                                        .urlToImage,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 7),
                              height: size.height *
                                  ((orientation == Orientation.landscape
                                      ? 0.24
                                      : 0.14)),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    news[index +
                                        (orientation ==
                                            Orientation
                                                .landscape
                                            ? 0
                                            : 1)]
                                        .title,
                                    style: TextStyle(
                                      fontSize: height > 700 ? 15 : 13,
                                    ),
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        news[index +
                                            (orientation ==
                                                Orientation
                                                    .landscape
                                                ? 0
                                                : 1)]
                                            .source
                                            .name
                                            .length >
                                            20
                                            ? news[index +
                                            (orientation ==
                                                Orientation
                                                    .landscape
                                                ? 0
                                                : 1)]
                                            .source
                                            .name
                                            .substring(0, 20)
                                            : news[index +
                                            (orientation ==
                                                Orientation
                                                    .landscape
                                                ? 0
                                                : 1)]
                                            .source
                                            .name,
                                        style: TextStyle(
                                          fontSize: height > 700 ? 12 : 10,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        formatTime(DateTime
                                            .parse(news[index +
                                            (orientation ==
                                                Orientation
                                                    .landscape
                                                ? 0
                                                : 1)]
                                            .publishedAt)
                                            .millisecondsSinceEpoch),
                                        style: TextStyle(
                                          fontSize: height > 700 ? 10 : 8,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ))
        : Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "You have a network connection error, Please check your connection",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
