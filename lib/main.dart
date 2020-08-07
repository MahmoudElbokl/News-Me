import 'package:flutter/material.dart';
import 'package:news_me/controllers/theme_changer_provider.dart';
import 'package:news_me/controllers/news_articles_provider.dart';
import 'package:news_me/routes.dart';
import 'package:news_me/services/connectivity_service.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsArticlesProvider(),
        ),
        StreamProvider<bool>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
          lazy: false,
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
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModel>(context).currentTheme,
      title: "NewsMe",
      onGenerateRoute: Routes.routeGenerator,
      initialRoute: "/",
    );
  }
}
