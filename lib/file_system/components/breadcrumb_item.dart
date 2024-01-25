import 'package:flutter/material.dart';

class BreadcrumbItem extends StatelessWidget {
  const BreadcrumbItem({super.key, required this.item, this.divider});
  final Widget item;
  final Widget? divider;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [item, if (divider != null) divider!],
      ),
    );
  }
}
