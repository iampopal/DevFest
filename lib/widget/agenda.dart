import 'package:devfest/model/agenda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaWidtet extends StatelessWidget {
  final Agenda agenda;
  final Color accentColor;
  const AgendaWidtet({
    Key key,
    this.agenda,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat("hh:mm a").format(agenda.dateTime.toDate()),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: accentColor),
                ),
                Text(
                  agenda.min.toString() + " min",
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: accentColor),
                ),
              ],
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  agenda.title,
                  style: Theme.of(context).textTheme.body1,
                ),
                Text(
                  Agenda.getLevel(agenda) + " | " + agenda.person,
                  style: Theme.of(context).textTheme.body2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
