import 'package:flutter/material.dart';

class FriendsWidget extends StatelessWidget {
  final String name;
  FriendsWidget(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Text(
              name[0],
              style: TextStyle(fontSize: 42, color: Colors.white),
            ),
          ),
          SizedBox(width: 8),
          Text(name, style: TextStyle(fontSize: 51)),
        ],
      ),
    );
  }
}
