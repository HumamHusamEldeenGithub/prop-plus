import 'package:flutter/material.dart';

class MainTheme{
  static double fontXSmall = 12;
  static double fontSmall = 14;
  static double fontMedium = 16;
  static double fontLarge = 18;
  static double fontXLarge = 20;
  static double fontXXLarge = 24;
  static Color mainColor = Color(0xFF00B9FF);
  static Color secondaryColor = Color(0xFF3DD6EB);
  static Color greyedOutColor = Color(0xFF004353);
  static Color transMainColor = Color(0x6400B9FF);
  static Color heartColor = Color(0xFFff5959);
  static Color shadowColor = Color(0xFFC3BFBF);
  static Offset shadowOffest = Offset(0, 3);
  static double shadowBlurRadius = 6;
  static Color mainFontColor = Color(0xFF555555);
  static Color greyFontColor = Color(0xFFA5A5A5);
  static const pagePadding = 20.0;
  static ThemeData finalTheme = ThemeData(
    primaryColor: mainColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'OpenSans',
  );
}