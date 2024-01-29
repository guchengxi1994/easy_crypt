import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'breadcrumb.dart';
import 'breadcrumb_item.dart';

const double rowHeight = 28;

typedef OnIndexedItemClicked = void Function(int index);

class TitleBar extends StatelessWidget {
  TitleBar(
      {super.key,
      required this.routers,
      this.onPrevClick,
      this.onIndexedItemClicked,
      this.onRefreshClick});
  final List<String> routers;
  final VoidCallback? onPrevClick;
  final VoidCallback? onRefreshClick;
  final OnIndexedItemClicked? onIndexedItemClicked;

  late final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (onPrevClick != null) {
              onPrevClick!();
            }
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(rowHeight / 2)),
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: BreadCrumb(
                      controller: _controller,
                      breadcrumbItems: routers
                          .mapIndexed((i, e) => BreadcrumbItem(
                                item: InkWell(
                                  onTap: () {
                                    if (onIndexedItemClicked != null) {
                                      onIndexedItemClicked!(i);
                                    }
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      height: 25,
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Center(
                                        child: Text(
                                          routers[i],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                divider: i == routers.length - 1
                                    ? null
                                    : const SizedBox(
                                        width: 30,
                                        height: 25,
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.black,
                                        ),
                                      ),
                              ))
                          .toList(),
                    ),
                  )),
                ],
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            if (onRefreshClick != null) {
              onRefreshClick!();
            }
          },
          child: const Icon(
            Icons.refresh,
            color: Colors.black,
            size: 20,
          ),
        ),
      ],
    );
  }
}
