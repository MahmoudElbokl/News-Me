import 'package:flutter/material.dart';
import 'package:news_me/views/article_details_screen.dart';
import 'package:news_me/views/home_Screen.dart';
import 'package:news_me/views/onboarding_screen.dart';
import 'package:news_me/views/splach_screen.dart';

class Routes {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
        break;
      case '/onBoardingScreen':
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
        );
        break;
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ));
        break;
    }
  }
}
