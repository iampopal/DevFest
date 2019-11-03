import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Firestore firebase() {
    final _firebase = Firestore.instance;

    return _firebase;
  }
}
