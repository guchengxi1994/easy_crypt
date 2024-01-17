import 'package:flutter/material.dart';

class ExpandCollapseNotifier extends ChangeNotifier {
  bool isExpanded = false;

  final double minWidth;
  final double maxWidth;
  ExpandCollapseNotifier({required this.minWidth, required this.maxWidth});

  late double currentWidth = minWidth;

  bool changeSidemenuWidth(DragUpdateDetails details) {
    currentWidth = currentWidth + details.delta.dx;
    if (currentWidth >= maxWidth) {
      isExpanded = true;
      currentWidth = maxWidth;
      notifyListeners();
    }

    if (currentWidth <= minWidth) {
      isExpanded = false;
      currentWidth = minWidth;
      notifyListeners();
    }
    return isExpanded;
  }
}
