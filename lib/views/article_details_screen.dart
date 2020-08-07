import 'package:flutter/material.dart';
import 'package:news_me/Models/news_model.dart';
import 'package:news_me/views/widgets/alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:news_me/views/widgets/main_scaffold.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;

  ArticleDetails(this.article);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MainScaffold(
      title: article.title.length > 20
          ? "${article.title.split(" ")[0]} ${article.title.split(" ")[1]} ${article.title.split(" ")[2]}"
          : article.title,
      body: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: <Widget>[
            Container(
              height: orientation == Orientation.landscape
                  ? size.height * 0.37
                  : size.height * 0.30,
              width: orientation == Orientation.landscape
                  ? size.width * 0.40
                  : double.maxFinite,
              child: article.urlToImage == null
                  ? Image.asset("assets/images/news-placeholder.png")
                  : FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          AssetImage("assets/images/news-placeholder.png"),
                      image: NetworkImage(
                        article.urlToImage,
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: (orientation == Orientation.landscape)
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

Widget detailsContent(Article article, context, bool space) {
  final height = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Align(
        alignment: Alignment.center,
        child: Text(
          article.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: height > 700 ? 17 : 15, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      AutoSizeText(
        article.content == null ? article.description : article.content,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: height > 700 ? 16 : 13),
        maxLines: 7,
      ),
      space
          ? Spacer()
          : SizedBox(
              height: 15,
            ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "To see the full article go to:",
            style: TextStyle(fontSize: height > 700 ? 14 : 11),
            textAlign: TextAlign.left,
          ),
          FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              if (await canLaunch(article.url)) {
                await launch(article.url).catchError(
                  showErrorAlertDialog(context, "there are a connection error"),
                );
              } else {
                showErrorAlertDialog(context, "there are a connection error");
              }
            },
            child: AutoSizeText(
              "${article.url}",
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
              maxLines: 2,
            ),
          ),
        ],
      ),
    ],
  );
}
