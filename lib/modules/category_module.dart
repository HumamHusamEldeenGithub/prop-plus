import 'package:flutter/material.dart';

class CategoryModel {
  bool isSelected;
  IconData icon;
  String title;
  CategoryModel(this.icon, this.title, this.isSelected);
}