import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNavigatorNotifier extends Notifier<int> {
  static final PageController controller = PageController();

  @override
  int build() {
    return 0;
  }

  changeState(int i) {
    if (state != i) {
      state = i;
      controller.jumpToPage(i);
    }
  }
}

final pageNavigator =
    NotifierProvider<PageNavigatorNotifier, int>(() => PageNavigatorNotifier());
