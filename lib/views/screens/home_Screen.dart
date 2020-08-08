import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news_me/views/widgets/main_scaffold.dart';
import 'package:news_me/views/widgets/shimmer_list.dart';
import 'package:news_me/controllers/news_articles_provider.dart';
import 'package:news_me/controllers/theme_changer_provider.dart';
import 'package:news_me/views/widgets/close_app_dialoge.dart';
import 'package:news_me/views/widgets/category_button.dart';
import 'package:news_me/views/widgets/category_grid_view.dart';
import 'package:news_me/views/widgets/category_horizontal_articles.dart';
import 'package:news_me/views/widgets/home_header_article.dart';
import 'package:news_me/views/widgets/home_articles_list_.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  List<String> topics = [
    "general",
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology",
  ];

  _refreshData(int page) {
    Provider.of<NewsArticlesProvider>(context, listen: false)
        .fetchAllNews(page);
  }

  _onCategoryRefresh(bool isRefresh, String topic) {
    Provider.of<NewsArticlesProvider>(context, listen: false)
        .fetchTopicsNews(isRefresh, topic);
  }

  int page = 1;

  @override
  void initState() {
    _refreshData(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsArticlesProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: (context),
          child: closeAppDialog(context),
        );
      },
      child: SafeArea(
        child: MainScaffold(
            navigationDrawer: true,
            title: "Explore",
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                // categories list
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topics.length + 1,
                      padding: EdgeInsets.only(bottom: 15),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return categoryButton(_selectedCategory, index, "ALL",
                              () {
                            if (_selectedCategory != index) {
                              _selectedCategory = index;
                              page = 1;
                              _refreshData(page);
                            }
                          });
                        }
                        return categoryButton(_selectedCategory, index,
                            topics[index - 1].toUpperCase(), () {
                          if (_selectedCategory != index) {
                            _selectedCategory = index;
                            _onCategoryRefresh(false, topics[index - 1]);
                          }
                          setState(() {});
                        });
                      }),
                ),
                // articles
                Expanded(
                  child: Provider.of<NewsArticlesProvider>(context).isLoading
                      // loading shimmer
                      ? ShimmerList()
                      : LiquidPullToRefresh(
                          color: Theme.of(context).accentColor,
                          springAnimationDurationInMilliseconds: 300,
                          onRefresh: () async {
                            page = 1;
                            _selectedCategory != 0
                                ? _onCategoryRefresh(
                                    true, topics[_selectedCategory - 1])
                                : _refreshData(page);
                          },
                          child: _selectedCategory != 0
                              ? ListView(
                                  children: <Widget>[
                                    Container(
                                      height: height - 150,
                                      child: Column(
                                        children: <Widget>[
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? SizedBox.shrink()
                                              : HorizontalArticlesScroll(),
                                          Expanded(
                                            child: GridViewArticles(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                            itemCount: provider.allNews.length > 16
                                ? 18
                                : provider.allNews.length + 1,
                            itemBuilder: (context, index) {
                              // some Api Articles is duplicated so it is a check to delete this duplication
                              if (provider.allNews[index].title ==
                                  provider.allNews[index + 1].title) {
                                return SizedBox.shrink();
                              }
                              if (index == 0) {
                                return orientation !=
                                    Orientation.landscape
                                    ? HomeHeaderArticle(
                                    provider.allNews[index])
                                    : SizedBox.shrink();
                                    }
                                    if (index == 1) {
                                      return orientation !=
                                              Orientation.landscape
                                          ? Container(
                                              color: Provider.of<ThemeModel>(
                                                              context)
                                                          .currentTheme ==
                                                      darkTheme
                                                  ? Colors.grey[850]
                                                  : Colors.grey[830],
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        width: double.infinity,
                                        child: Text("Top Stories",
                                            style: TextStyle(
                                              fontSize:
                                              height > 700 ? 18 : 16,
                                            )),
                                      )
                                          : SizedBox.shrink();
                                    }
                              if (index == 18 ||
                                  index == provider.allNews.length + 1) {
                                page++;
                                _refreshData(page);
                                return CircularProgressIndicator();
                              } else {
                                return HomeArticleListView(index);
                              }
                                  },
                                ),
                        ),
                ),
              ],
            )),
      ),
    );
  }
}
