import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardNotifier extends Notifier<double> {
  final double screenWidth;
  static const double minWidth = 300;

  BoardNotifier({required this.screenWidth});

  late double currentScreenWidth = screenWidth;
  late double currentWidth = screenWidth / 2;

  setScreenWidth(double width) {
    currentScreenWidth = width;
  }

  changeWidth(DragUpdateDetails details) {
    currentWidth = currentWidth + details.delta.dx;

    if (currentWidth >= minWidth &&
        currentWidth <= currentScreenWidth - minWidth) {
      state = currentWidth;
    }
  }

  @override
  double build() {
    return currentWidth;
  }
}
