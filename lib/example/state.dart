import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Counter"),
        ),
        body: Column(
          children: [
            ListTile(title: Text("Ahmad")),
            ListTile(title: Text("Zabi")),
            ListTile(title: Text("Ratib"))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _increment,
          child: Icon(Icons.plus_one),
        ),
      ),
    );
  }

  _increment() {
    setState(() {
      count++;
    });
  }
}
