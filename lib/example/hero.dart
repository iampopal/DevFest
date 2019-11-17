import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HeroScreen1(),
    );
  }
}

class HeroScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
      ),
      body: InkWell(
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (_) => HeroScreen2());
          Navigator.push(context, route);
        },
        child: Hero(
          tag: "flutterLogo",
          child: Container(
            width: 100,
            height: 100,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}

class HeroScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero Screen"),
      ),
      body: Hero(
        tag: "flutterLogo",
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
