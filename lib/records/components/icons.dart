import 'package:flutter/material.dart';

class ProcessTypeIcons {
  static const double size = 20;

  static Widget encrypt() {
    return const Icon(
      Icons.lock,
      size: size,
    );
  }

  static Widget decrypt() {
    return const Icon(
      Icons.lock_open,
      size: size,
    );
  }

  static Widget transfer() {
    return Transform.rotate(
      angle: 3.14 / 2,
      child: const Icon(
        Icons.move_up,
        size: size,
      ),
    );
  }

  static Widget encryptAndTransfer() {
    return Stack(
      children: [
        Transform.rotate(
          angle: 3.14 / 2,
          child: const Icon(
            Icons.move_up,
            size: size,
          ),
        ),
        const Positioned(
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.lock,
              size: 10,
              color: Colors.amber,
            ))
      ],
    );
  }
}
