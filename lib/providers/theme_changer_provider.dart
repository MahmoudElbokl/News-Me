import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType { Light, Dark }

bool darkThemeChoose = false;

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkThemeChoose ? darkTheme : lightTheme;
  ThemeType _themeType = ThemeType.Light;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}

ThemeData darkTheme = ThemeData.dark().copyWith(
  accentColor: Colors.blueGrey,
  textTheme: TextTheme(
    body1: GoogleFonts.mukta(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
    body2: GoogleFonts.mukta(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    color: Colors.red,
  ),
  textTheme: TextTheme(
    body1: GoogleFonts.mukta(
        color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
    body2: GoogleFonts.mukta(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
  ),
);