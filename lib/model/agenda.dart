import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/page/agenda.dart';

class Agenda {
  final Timestamp dateTime;
  final int min;
  final String title;
  final int level;
  final String person;
  final int section;
  final DocumentReference reference;

  static String getLevel(Agenda agenda) {
    if (agenda.level == null) return '';
    switch (agenda.level) {
      case 1:
        return "Beginner";
      case 3:
        return "Intermediate";
      case 3:
        return "Advance";
    }
  }

  static AgendaType agendaType(Agenda agenda) {
    if (agenda.section == null) return AgendaType.NONE;

    switch (agenda.section) {
      case 1:
        return AgendaType.Android;
      case 2:
        return AgendaType.Ai;
      case 3:
        return AgendaType.Flutter;
      case 4:
        return AgendaType.Cloud;
      case 5:
        return AgendaType.Web;
      default:
        return AgendaType.NONE;
    }
  }

  Agenda({
    this.dateTime,
    this.title,
    this.person,
    this.section,
    this.reference,
    this.level,
    this.min,
  });

  Map<String, dynamic> toMap() => {
        "dateTime": dateTime,
        "title": title,
        "min": min,
        "person": person,
        "level": level,
        "section": section,
      };

  Agenda.fromMap(Map<String, dynamic> data, {this.reference})
      : dateTime = data["dateTime"],
        title = data["title"],
        level = data["level"],
        min = data["min"],
        person = data["person"],
        section = data["section"];

  Agenda.fromFirestore(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
