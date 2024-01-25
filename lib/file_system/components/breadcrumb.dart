import 'package:flutter/material.dart';

import 'breadcrumb_item.dart';

class BreadCrumb extends StatelessWidget {
  const BreadCrumb({
    super.key,
    required this.breadcrumbItems,
    required this.controller,
  });
  final List<BreadcrumbItem> breadcrumbItems;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });

    return ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: breadcrumbItems.length,
        itemBuilder: (c, i) => breadcrumbItems[i]);
  }
}
