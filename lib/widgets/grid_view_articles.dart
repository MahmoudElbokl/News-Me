import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/news_articles_provider.dart';

class GridViewArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topicsNews =
        Provider.of<NewsArticles>(context, listen: false).topicsNews;
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        itemCount: topicsNews.length > 14
            ? orientation == Orientation.landscape ? 12 : 10
            : orientation == Orientation.landscape
            ? topicsNews.length
            : topicsNews.length - 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
          childAspectRatio:
              orientation == Orientation.landscape ? 2.40 / 1.25 : 2 / 2.60,
          crossAxisSpacing: orientation == Orientation.landscape ? 10 : 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: size.height * 0.2,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.45,
                  height: size.height * 0.30,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: size.width * 0.45,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5.0,
                              spreadRadius: 1,
                              offset: Offset(
                                3.0,
                                2.0,
                              ),
                            )
                          ],
                          image: topicsNews[index +
                                          ((orientation ==
                                                  Orientation.landscape)
                                              ? 0
                                              : 4)]
                                      .urlToImage ==
                                  null
                              ? AssetImage("assets/images/news-placeholder.png")
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    topicsNews[index +
                                            ((orientation ==
                                                    Orientation.landscape)
                                                ? 0
                                                : 4)]
                                        .urlToImage,
                                  )),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: size.width * 0.45,
                          height: size.height * 0.07,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            topicsNews[index +
                                    ((orientation == Orientation.landscape)
                                        ? 0
                                        : 4)]
                                .title,
                            style: Theme.of(context).textTheme.body2.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
