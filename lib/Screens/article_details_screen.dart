import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_me/Models/news.dart';
import 'package:news_me/Shared_ui/main_scaffold.dart';
import 'package:news_me/utilites.dart';

class ArticleDetails extends StatelessWidget {
  static final routeName = "article_details";

  @override
  Widget build(BuildContext context) {
    News article = ModalRoute.of(context).settings.arguments as News;
    final mediaQuery = MediaQuery.of(context);
    return MainScaffold(
      title:
          "${article.title.split(" ")[0]} ${article.title.split(" ")[1]} ${article.title.split(" ")[2]}",
      tabBar: null,
      body: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: <Widget>[
            Container(
              height: orientation == Orientation.landscape
                  ? mediaQuery.size.height * 0.50 -
                      (AppBar().preferredSize.height + mediaQuery.padding.top)
                  : mediaQuery.size.height * 0.42 -
                      (AppBar().preferredSize.height + mediaQuery.padding.top),
              width: orientation == Orientation.landscape
                  ? mediaQuery.size.width * 0.40
                  : double.maxFinite,
              child: article.urlToImage == null
                  ? Image.asset("images/news-placeholder.png")
                  : FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage("images/news-placeholder.png"),
                      image: NetworkImage(
                        article.urlToImage,
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: (article.content != null ||
                        orientation == Orientation.landscape)
                    ? SingleChildScrollView(
                        child: detailsContent(article, context, false),
                      )
                    : detailsContent(article, context, true),
              ),
            )
          ],
        );
      }),
    );
  }
}

Widget detailsContent(News article, context, bool space) {
  return Column(
    children: <Widget>[
      Text(
        article.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      Text(
        article.content == null ? article.description : article.content,
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      space ? Spacer() : SizedBox.shrink(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "To see the full article go to:",
            style: TextStyle(fontSize: 14),
          ),
          FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              if (await canLaunch(article.url)) {
                await launch(article.url).catchError(showErrorAlertDialog(
                    context, "there are a connection error"));
              } else {
                showErrorAlertDialog(context, "there are a connection error");
              }
            },
            child: Text(
              "${article.url}",
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    ],
  );
}
