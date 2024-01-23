import 'package:flutter/material.dart';

class AppStyle {
  static const double appbarHeight = 40;
  static const double sidebarWidth = 150;

  static Color progressColor = Colors.lightBlueAccent;

  AppStyle._();

  static const leftTopRadius = BorderRadius.only(topLeft: Radius.circular(10));
  static const titleTextColor = Color.fromARGB(255, 117, 117, 117);

  static const appColor = Color.fromARGB(255, 114, 245, 241);

  static const double rowIconSize = 18;
  static const double rowImageSize = 25;

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

  static const InputDecoration inputDecoration = InputDecoration(
      errorStyle: TextStyle(height: 0),
      hintStyle:
          TextStyle(color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
      contentPadding: EdgeInsets.only(left: 10, bottom: 15),
      border: InputBorder.none,
      // focusedErrorBorder:
      //     OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppStyle.appColor)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppStyle.appColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159))));
}
