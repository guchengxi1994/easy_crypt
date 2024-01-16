import 'package:easy_crypt/bridge/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flow_chart/flutter_flow_chart.dart';
import 'package:collection/collection.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  List<Widget> children = [];

  refreshChildren(List<FlowElement> elements) async {
    children.clear();
    final List<String> operators = elements.map((e) => e.text).toList();

    List<String> results = await api.flowPreview(operators: operators);

    children = elements
        .mapIndexed((i, e) => Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ]),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  e.text == '开始'
                      ? "Orig: I love China"
                      : "${e.text}: ${results[i - 1]}",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ]),
      child: ListView.separated(
        itemBuilder: (c, i) => children[i],
        itemCount: children.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
