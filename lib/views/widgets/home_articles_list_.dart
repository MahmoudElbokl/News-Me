import 'package:flutter/material.dart';
import 'package:news_me/controllers/news_articles_provider.dart';
import 'package:news_me/views/screens/article_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';

class HomeArticleListView extends StatelessWidget {
  final int index;

  HomeArticleListView(this.index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final provider = Provider.of<NewsArticlesProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ArticleDetails(provider.allNews
              .data[index + (orientation == Orientation.landscape ? 0 : 1)]);
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: Card(
          child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: size.height *
                        ((orientation == Orientation.landscape ? 0.25 : 0.15)),
                    width: size.width * 0.3,
                    child: provider
                                .allNews
                                .data[index +
                                    (orientation == Orientation.landscape
                                        ? 0
                                        : 1)]
                                .urlToImage ==
                            null
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4)),
                            child: Image.asset(
                                "assets/images/news-placeholder.png"),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4)),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: AssetImage(
                                  "assets/images/news-placeholder.png"),
                              image: NetworkImage(
                                provider
                                    .allNews
                                    .data[index +
                                        (orientation == Orientation.landscape
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
                        ((orientation == Orientation.landscape ? 0.24 : 0.14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          provider
                              .allNews
                              .data[index +
                                  (orientation == Orientation.landscape
                                      ? 0
                                      : 1)]
                              .title,
                          style: TextStyle(
                            fontSize: size.height > 700 ? 15 : 13,
                          ),
                          maxLines: 2,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              provider
                                          .allNews
                                          .data[index +
                                              (orientation ==
                                                      Orientation.landscape
                                                  ? 0
                                                  : 1)]
                                          .source
                                          .name
                                          .length >
                                      20
                                  ? provider
                                      .allNews
                                      .data[index +
                                          (orientation == Orientation.landscape
                                              ? 0
                                              : 1)]
                                      .source
                                      .name
                                      .substring(0, 20)
                                  : provider
                                      .allNews
                                      .data[index +
                                          (orientation == Orientation.landscape
                                              ? 0
                                              : 1)]
                                      .source
                                      .name,
                              style: TextStyle(
                                fontSize: size.height > 700 ? 12 : 10,
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
                              formatTime(provider
                                  .allNews
                                  .data[index +
                                      (orientation == Orientation.landscape
                                          ? 0
                                          : 1)]
                                  .publishedAt
                                  .millisecondsSinceEpoch),
                              style: TextStyle(
                                fontSize: size.height > 700 ? 10 : 8,
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
}
