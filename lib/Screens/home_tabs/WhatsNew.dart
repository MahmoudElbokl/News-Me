import 'package:flutter/material.dart';
import 'package:news_me/widgets/whatsnew_header.dart';
import 'package:news_me/widgets/whatsnews_listview.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:news_me/providers/news_articles_provider.dart';
import 'package:news_me/providers/theme_changer_provider.dart';
import 'package:news_me/Shared_ui/shimmer_list.dart';

class WhatsNew extends StatefulWidget {
  final statusBarSize;

  WhatsNew(this.statusBarSize);

  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  bool isInit = true;

  _refreshData() async {
    final provider = Provider.of<NewsArticles>(context, listen: false);
    await provider.fetchAllNews();
//        .catchError((error) {
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        provider.setNetwork(false);
//        provider.setLoad(false);
//        print("1534 refresh");
//        Future.value();
//      });
//    });
//    Future.delayed(Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      final provider = Provider.of<NewsArticles>(context, listen: false);
      if (provider.allNews.length == 0) {
        await provider.fetchAllNews();
//            .catchError((error) {
//          WidgetsBinding.instance.addPostFrameCallback((_) {
//            print("After All");
//            provider.setNetwork(false);
//            provider.setLoad(false);
//          });
//        });
      }
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsArticles>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final pullToRefreshColor =
        Provider.of<ThemeModel>(context, listen: false).currentTheme ==
                lightTheme
            ? Colors.red[100]
            : Colors.blueGrey;
    return Provider.of<NewsArticles>(context).isLoading
        ? ShimmerList()
        : LiquidPullToRefresh(
                color: pullToRefreshColor,
                onRefresh: () async {
                  return _refreshData();
                },
                springAnimationDurationInMilliseconds: 300,
                child: ListView.builder(
                  itemCount: provider.allNews.length > 16
                      ? 17
                      : provider.allNews.length,
                  itemBuilder: (context, index) {
                    if (provider.allNews[index].title ==
                        provider.allNews[index + 1].title) {
                      return SizedBox
                          .shrink(); // some Api Articles is duplicated so it is a check to delete this duplication
                    }
                    if (index == 0) {
                      return orientation != Orientation.landscape
                          ? DrawWhatsNewsHeader(provider.allNews[index])
                          : SizedBox.shrink();
                    }
                    if (index == 1) {
                      return orientation != Orientation.landscape
                          ? Container(
                              color: Provider.of<ThemeModel>(context)
                                          .currentTheme ==
                                      darkTheme
                                  ? Colors.grey[850]
                                  : Colors.grey[830],
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              width: double.infinity,
                              child: Text("Top Stories",
                                  style: TextStyle(
                                    fontSize: height > 700 ? 18 : 16,
                                  )),
                            )
                          : SizedBox.shrink();
                    } else {
                      return WhatsNewListView(index);
                    }
                  },
                ),
              )
            ;
  }
}
