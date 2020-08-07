import 'package:flutter/material.dart';
import 'package:news_me/views/article_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_me/controllers/news_articles_provider.dart';

class HorizontalArticlesScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topicsNews =
        Provider.of<NewsArticlesProvider>(context, listen: false).topicsNews;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: size.height * 0.3,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: size.width * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ArticleDetails(topicsNews[index]);
                    }));
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: size.width * 0.8,
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
                      width: size.width * 0.75,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        topicsNews[index].title,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: size.height > 700 ? 14 : 12,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ]),
                ),
                (index == 3)
                    ? SizedBox(
                        width: size.width * 0.025,
                      )
                    : SizedBox.shrink(),
              ],
            );
          }),
    );
  }
}
