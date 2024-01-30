import 'package:flutter/material.dart';

import 'components/records.dart';

class ProcessRecordsScreen extends StatefulWidget {
  const ProcessRecordsScreen({super.key});

  @override
  State<ProcessRecordsScreen> createState() => _ProcessRecordsScreenState();
}

class _ProcessRecordsScreenState extends State<ProcessRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return const RecordsWidget();
  }
}
