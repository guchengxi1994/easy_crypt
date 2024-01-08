import 'package:flutter/material.dart';

class AppStyle {
  static const double appbarHeight = 40;
  static const double sidebarWidth = 150;

  AppStyle._();

  static const leftTopRadius = BorderRadius.only(topLeft: Radius.circular(10));
  static const titleTextColor = Color.fromARGB(255, 117, 117, 117);

  static List<Color> catalogCardBorderColors = [
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.green,
    Colors.deepPurpleAccent,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.pink,
  ];
}
