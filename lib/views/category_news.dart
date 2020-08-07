import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news_me/views/widgets/mynews_grid_view.dart';
import 'package:news_me/views/widgets/mynews_horizontal_articles.dart';

Widget categoryNews(BuildContext context, Color pullToRefreshColor,
    Function onCategoryRefresh, double height) {
  return LiquidPullToRefresh(
    color: pullToRefreshColor,
    springAnimationDurationInMilliseconds: 300,
    onRefresh: () {
      return onCategoryRefresh();
    },
    child: ListView(
      children: <Widget>[
        Container(
          height: height - 150,
          child: Column(
            children: <Widget>[
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? SizedBox.shrink()
                  : HorizontalArticlesScroll(),
              Expanded(
                child: GridViewArticles(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
