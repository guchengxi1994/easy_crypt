import 'package:easy_crypt/common/dev_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/board_notifier.dart';
import 'package:easy_crypt/layout/desktop_layout.dart' show maxWidth, minWidth;

class Board extends ConsumerStatefulWidget {
  const Board({super.key, required this.left, required this.right});
  final Widget left;
  final Widget right;

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  late double screenWidth = MediaQuery.of(context).size.width;

  late final provider = NotifierProvider<BoardNotifier, double>(
    () {
      if (DevUtils.navigationKey.currentState!.widget.extended) {
        screenWidth = MediaQuery.of(context).size.width - maxWidth;

        return BoardNotifier(screenWidth: screenWidth);
      } else {
        screenWidth = MediaQuery.of(context).size.width - minWidth;
        return BoardNotifier(screenWidth: screenWidth);
      }
    },
  );

  @override
  void didUpdateWidget(covariant Board oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (DevUtils.navigationKey.currentState!.widget.extended) {
      screenWidth = MediaQuery.of(context).size.width - maxWidth;
      ref.read(provider.notifier).setScreenWidth(screenWidth);
    } else {
      screenWidth = MediaQuery.of(context).size.width - minWidth;
      ref.read(provider.notifier).setScreenWidth(screenWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftWidth = ref.watch(provider);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: leftWidth,
                child: Card(
                  child: widget.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: screenWidth - leftWidth,
                child: Card(
                  child: widget.right,
                ),
              )
            ],
          ),
          Positioned(
              left: leftWidth - 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeft,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    ref.read(provider.notifier).changeWidth(details);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 20,
                    height: MediaQuery.of(context).size.height,
                    // child: const SizedBox.expand(),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
