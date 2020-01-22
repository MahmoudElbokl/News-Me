import 'package:flutter/material.dart';
import 'package:time_formatter/time_formatter.dart';

import 'package:news_me/Screens/article_details_screen.dart';
import 'package:news_me/Models/news.dart';

class DrawWhatsNewsHeader extends StatelessWidget {
  final News news;

  DrawWhatsNewsHeader(this.news);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ArticleDetails.routeName, arguments: news);
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: news.urlToImage == null
                  ? AssetImage("assets/images/news-placeholder.png")
                  : NetworkImage(news.urlToImage),
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
                  "${news.title}",
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      news.source.name,
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
                              .parse(news.publishedAt)
                              .millisecondsSinceEpoch),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body2
                              .copyWith(fontSize: height > 700 ? 14 : 10),
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
    );
  }
}
