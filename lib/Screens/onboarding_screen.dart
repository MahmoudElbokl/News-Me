import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:news_me/Models/onboarding_page.dart';
import 'package:news_me/Screens/home_Screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<OnBoardingPage> onBoardingPages = [
    OnBoardingPage(
      image: "assets/images/NewsMe.png",
      title: "News Me",
      details: "One place for all your news",
    ),
    OnBoardingPage(
      image: "assets/images/topicselection.png",
      title: "My News feature",
      details: "All your interesting news in one screen",
    ),
  ];

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: onBoardingPages.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      onBoardingPages[index].image,
                      height: size.height * 0.3,
                      width: size.width * 0.7,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Text(
                        onBoardingPages[index].title,
                        style: Theme.of(context).textTheme.body1,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    child: Text(
                      onBoardingPages[index].details,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    width: size.width * 0.75,
                  ),
                ],
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: size.height * 0.5),
            child: SmoothPageIndicator(
              controller: controller,
              count: onBoardingPages.length,
              effect: ExpandingDotsEffect(
                expansionFactor: 2,
                dotColor: Colors.red,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: size.height * 0.85),
            child: FlatButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Text(
                  "Get Started",
                  style:
                      Theme.of(context).textTheme.body2.copyWith(fontSize: 20),
                ),
                color: Colors.red,
                onPressed: () {
                  _updateSeen();
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                }),
          ),
        ],
      ),
    );
  }
}
