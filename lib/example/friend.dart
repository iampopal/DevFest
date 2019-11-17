import 'package:devfest/example/friendWidget.dart';
import 'package:flutter/material.dart';

class FriendsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Friends"),
        ),
        body: ListView(
          children: <Widget>[
            FriendsWidget("Wahid"),
            FriendsWidget("Rateb"),
            FriendsWidget("Ahmad"),
            FriendsWidget("Fazal"),
            FriendsWidget("Khan"),
            FriendsWidget("Ameen"),
          ],
        ),
      ),
    );
  }
}
