import 'dart:async';

import 'package:flutter/material.dart';

class TimeOutWidget extends StatefulWidget {
  const TimeOutWidget({
    Key key,
  }) : super(key: key);

  @override
  _TimeOutWidgetState createState() => _TimeOutWidgetState();
}

class _TimeOutWidgetState extends State<TimeOutWidget> {
  Timer _timer;
  int days, hours, minuts, seconds;
  var eventTime = DateTime(2019, 11, 21, 8, 0, 0);

  void _updateTime() {
    DateTime now = DateTime.now();

    days = eventTime.difference(now).inDays;

    hours = DateTime(
      now.year,
      now.month,
      now.day,
      eventTime.hour,
    ).difference(now).inHours;

    int hoursDiffSeconds = DateTime(
      now.year,
      now.month,
      now.day,
      eventTime.hour,
    ).difference(now).inSeconds;

    hours = hours <= 0 && hoursDiffSeconds <= 0 ? hours + 23 : hours;

    minuts = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      60,
    ).difference(now).inMinutes;

    seconds = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      60,
    ).difference(now).inSeconds;
  }

  bool timeOutVisibity() {
    var diffSec = eventTime.difference(DateTime.now()).inSeconds - 1;
    bool visibility = diffSec >= 0;
    return visibility;
  }

  @override
  void initState() {
    _updateTime();

    if (timeOutVisibity()) {
      _timer = new Timer.periodic(Duration(seconds: 1), (t) {
        setState(() {
          _updateTime();
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: timeOutVisibity(),
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Container(
          width: 220,
          height: 38,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.blue,
              border:
                  Border.all(color: Color.fromARGB(40, 0, 0, 0), width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildText(value: days, name: "Days"),
                _buildDot(),
                _buildText(value: hours, name: "Hours"),
                _buildDot(),
                _buildText(value: minuts, name: "Minuts"),
                _buildDot(),
                _buildText(value: seconds, name: "Seconds"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildText({int value, String name}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          value.toString(),
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 9),
        )
      ],
    );
  }

  _buildDot() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          width: 6,
          height: 6,
          color: Colors.white,
        ),
      ),
    );
  }
}
