import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: Image.asset("assets/images/devfest.png"),
        ),
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.red,
        ),
        Expanded(child: _buildPages())
      ],
    );
  }

  _page2() {
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? Colors.blue : Colors.pink,
              child: Center(
                child: Text(
                  "Page",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: position % 2 == 0 ? Colors.blue : Colors.pink,
            child: Center(
              child: Text(
                "Page",
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ),
          );
        }
      },
      itemCount: 10,
    );
  }

  _buildPages() {
    return PageView(
      //pageSnapping: false,
      //scrollDirection: Axis.vertical,
      // physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.grey,
        ),
      ],
    );
  }
}
