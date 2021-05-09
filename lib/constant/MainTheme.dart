import 'package:flutter/material.dart';

class MainTheme{
  static Color mainColor = Color(0xFF00B9FF);
  static Color secondaryColor = Color(0xFF3DD6EB);
  static Color heart_color = Color(0xFFff5959);
  static ThemeData finalTheme = ThemeData(
    primaryColor: mainColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'OpenSans',
  );
}