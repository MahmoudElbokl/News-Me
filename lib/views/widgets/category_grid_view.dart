import 'package:flutter/material.dart';
import 'package:news_me/views/screens/article_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_me/controllers/news_articles_provider.dart';

class GridViewArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final topicsNews =
        Provider.of<NewsArticlesProvider>(context, listen: false).topicsNews;
    return GridView.builder(
      itemCount: topicsNews.data.length > 14
          ? orientation == Orientation.landscape ? 12 : 10
          : orientation == Orientation.landscape
              ? topicsNews.data.length
              : topicsNews.data.length - 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
        childAspectRatio:
            orientation == Orientation.landscape ? 2.40 / 1.3 : 2 / 2.60,
        crossAxisSpacing: orientation == Orientation.landscape ? 10 : 0,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ArticleDetails(topicsNews.data[
                  orientation == Orientation.landscape ? index : index + 4]);
            }));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: <Widget>[
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
                          image: topicsNews
                                      .data[index +
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
                                    topicsNews
                                        .data[index +
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
                          margin: EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            topicsNews
                                .data[index +
                                    ((orientation == Orientation.landscape)
                                        ? 0
                                        : 4)]
                                .title,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontSize: size.height > 700 ? 14 : 12,
                                    fontWeight: FontWeight.w800),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
