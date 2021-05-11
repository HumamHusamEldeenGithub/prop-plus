import 'package:flutter/material.dart';
import 'package:prop_plus/constant/MainTheme.dart';

class TrendingTheme{
  static Radius borderRadius = Radius.circular(8);
  static TextStyle titleTextStyle = TextStyle(color: MainTheme.mainFontColor, fontSize: MainTheme.fontSmall, fontWeight: FontWeight.w600);
  static TextStyle priceTextStyle = TextStyle(color: MainTheme.mainFontColor, fontSize: MainTheme.fontXSmall, fontWeight: FontWeight.w600);
  static TextStyle locationTextStyle = TextStyle(color: MainTheme.greyFontColor, fontSize: MainTheme.fontXSmall, fontWeight: FontWeight.w600);
}