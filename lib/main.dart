import 'package:flutter/material.dart';
import 'package:news_me/Models/theme_changer_provider.dart';
import 'package:news_me/Screens/article_details_screen.dart';
import 'package:news_me/Screens/edit_my_news.dart';
import 'package:news_me/Screens/home_Screen.dart';
import 'package:news_me/Screens/onboarding_screen.dart';
import 'package:news_me/Models/news_articles_provider.dart';
import 'package:news_me/models/mynews_sources_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _screen;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  SharedPreferences _pref = await SharedPreferences.getInstance();
  darkThemeChoose = _pref.getBool("darktheme");
  if (darkThemeChoose == null) {
    darkThemeChoose = false;
  }

  if (seen == null || seen == false) {
    _screen = OnBoardingScreen();
  } else {
    _screen = HomeScreen();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeModel(),
        ),
        ChangeNotifierProvider.value(
          value: MyNewsSources(),
        ),
        ChangeNotifierProvider.value(
          value: NewsArticles(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (c) => HomeScreen(),
        ArticleDetails.routeName: (c) => ArticleDetails(),
        EditMyNews.routeName: (c) => EditMyNews(),
      },
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModel>(context).currentTheme,
      title: "News Me",
      home: _screen,
    );
  }
}
