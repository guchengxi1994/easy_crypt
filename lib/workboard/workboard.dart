import 'package:flutter/material.dart';

import 'components/records.dart';

class Workboard extends StatefulWidget {
  const Workboard({super.key});

  @override
  State<Workboard> createState() => _WorkboardState();
}

class _WorkboardState extends State<Workboard> {
  @override
  Widget build(BuildContext context) {
    return const RecordsWidget();
  }
}
