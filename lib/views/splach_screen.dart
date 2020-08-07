import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 700),
    ).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('seen');
      Navigator.pushReplacementNamed(
          context,
          (seen == null || seen == false)
              ? "/onBoardingScreen"
              : "/homeScreen");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/NewsMe.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
