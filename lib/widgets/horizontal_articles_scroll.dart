import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/Screens/article_details_screen.dart';

class HorizontalArticlesScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topicsNews =
        Provider.of<NewsArticles>(context, listen: false).topicsNews;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      height: size.height * 0.30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ArticleDetails.routeName,
                        arguments: topicsNews[index]);
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3,
                            spreadRadius: 0.5,
                            offset: Offset(
                              2.0,
                              0.50,
                            ),
                          )
                        ],
                        image: topicsNews[index].urlToImage == null
                            ? AssetImage("assets/images/news-placeholder.png")
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  topicsNews[index].urlToImage,
                                ),
                              ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.90,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        topicsNews[index].title,
                        style: Theme.of(context).textTheme.body2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),
                (index == 3)
                    ? SizedBox(
                        width: size.width * 0.05,
                      )
                    : SizedBox.shrink(),
              ],
            );
          }),
    );
  }
}
