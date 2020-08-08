import 'package:flutter/material.dart';
import 'package:news_me/views/screens/home_Screen.dart';
import 'package:news_me/views/screens/onboarding_screen.dart';
import 'package:news_me/views/screens/splach_screen.dart';

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
