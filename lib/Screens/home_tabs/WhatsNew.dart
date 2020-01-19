import 'package:flutter/material.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';

import 'package:news_me/Models/news.dart';
import 'package:news_me/Screens/article_details_screen.dart';
import 'package:news_me/widgets/whatsnew_header.dart';

class WhatsNew extends StatelessWidget {
  final List<News> news;

  WhatsNew(this.news);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height * 0.75;
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
          height: height,
          color: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              orientation != Orientation.landscape
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ArticleDetails.routeName,
                            arguments: news[0]);
                      },
                      child: DrawHeader(news[0]))
                  : SizedBox.shrink(),
              orientation != Orientation.landscape
                  ? Container(
                      color: Provider.of<ThemeModel>(context).currentTheme ==
                              darkTheme
                          ? Colors.grey[850]
                          : Colors.grey[830],
                      padding:
                          const EdgeInsets.only(left: 10, top: 7, bottom: 7),
                      width: double.infinity,
                      child: Text(
                        "Top Stories",
                        style: Provider.of<ThemeModel>(context).currentTheme ==
                                darkTheme
                            ? Theme.of(context).textTheme.title
                            : Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.black),
                      ),
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: Container(
                  color: Provider
                      .of<ThemeModel>(context)
                      .currentTheme == lightTheme
                      ? Colors.grey.shade200
                      : Colors.grey[850],
                  child: ListView.builder(
                    padding: const EdgeInsets.only(right: 3),
                    itemCount: news.length > 15 ? 15 : news.length,
                    itemBuilder: (context, index) {
                      if (news[index +
                          (orientation == Orientation.landscape ? 0 : 1)]
                          .title ==
                          news[index +
                              (orientation == Orientation.landscape ? 1 : 2)]
                              .title) {
                        return SizedBox.shrink();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ArticleDetails.routeName,
                                arguments: news[index +
                                    (orientation == Orientation.landscape
                                        ? 0
                                        : 1)]);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 10, bottom: 5),
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
                                          ? Image.asset(
                                          "assets/images/news-placeholder.png")
                                          : FadeInImage(
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
                                  Expanded(
                                    child: Container(
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
                                                    Orientation.landscape
                                                    ? 0
                                                    : 1)]
                                                .title,
                                            style: TextStyle(
                                              fontSize: 15,
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
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .body1
                                                    .copyWith(fontSize: 12),
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
                                                  fontSize: 10,
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
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
