import 'package:flutter/material.dart';

class MainTheme{
  static double fontXSmall = 12;
  static double fontSmall = 14;
  static double fontMedium = 16;
  static double fontLarge = 18;
  static double fontXLarge = 20;
  static Color mainColor = Color(0xFF00B9FF);
  static Color secondaryColor = Color(0xFF3DD6EB);
  static Color heartColor = Color(0xFFff5959);
  static ThemeData finalTheme = ThemeData(
    primaryColor: mainColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'OpenSans',
  );
}