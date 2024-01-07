// ignore_for_file: avoid_print

import 'dart:isolate';

import 'package:easy_crypt/bridge/native.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                run();
              },
              child: Text(
                'start isolate',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final SendPort? sendPort;

  Message({this.sendPort});
}

run() async {
  ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    print(message);
  });

  Isolate.spawn<Message>((message) {
    exec(message);
  }, Message(sendPort: receivePort.sendPort));
}

void exec(Message message) async {
  print("new isolate doWork start");
  await Future.delayed(const Duration(seconds: 5)).then(
    (value) async {
      await api.testEncrypt();
    },
  );
  print("new isolate doWork end");
  // return "complete";
  message.sendPort?.send("complete");
}
