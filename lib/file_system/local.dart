import 'package:flutter/material.dart';

class LocalFilePreview extends StatelessWidget {
  const LocalFilePreview({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width ?? 0.8 * MediaQuery.of(context).size.width,
        height: height ?? 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.white),
      ),
    );
  }
}
