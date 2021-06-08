import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';

class RealStateTheme{
  static Radius borderRadius = Radius.circular(8);
  static const double cardPadding = 8;
  static TextStyle titleTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: MainTheme.fontMedium, color: MainTheme.mainFontColor);
  static TextStyle locationTextStyle = TextStyle(fontSize: MainTheme.fontXSmall, color: MainTheme.greyFontColor);
  static TextStyle priceTextStyle = TextStyle(fontSize: MainTheme.fontLarge, color: MainTheme.mainFontColor, fontWeight: FontWeight.bold);
  static TextStyle reviewTextStyle = TextStyle(fontSize: MainTheme.fontXSmall, color: MainTheme.mainFontColor);
  static TextStyle perNightTextStyle = TextStyle(fontSize: MainTheme.fontXSmall, color: MainTheme.mainFontColor);
}