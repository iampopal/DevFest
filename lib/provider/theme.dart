import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  final _primaryTheme = ThemeData(
    textTheme: TextTheme(
      title: TextStyle(fontSize: 28),
      button: TextStyle(fontSize: 14),
    ),
  );

  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    accentColor: Colors.white,
    cardColor: Colors.grey[900],
    accentIconTheme: IconThemeData(color: Colors.black),
    primaryIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.grey[800],
    textTheme: TextTheme(
      title: TextStyle(fontSize: 28),
      button: TextStyle(color: Colors.grey[100], fontSize: 14),
      body1: TextStyle(color: Colors.grey[100], fontSize: 16),
      body2: TextStyle(color: Colors.grey[100], fontSize: 12),
      display1: TextStyle(color: Colors.white),
    ),
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    dividerColor: Colors.grey[400],
    accentIconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(color: Colors.grey[700]),
    textTheme: TextTheme(
      title: TextStyle(fontSize: 28),
      button: TextStyle(color: Colors.grey[800], fontSize: 14),
      body1: TextStyle(color: Colors.grey[800], fontSize: 16),
      body2: TextStyle(color: Colors.grey[600], fontSize: 11),
      display1: TextStyle(color: Colors.black),
    ),
  );

  void changeTheme(bool isDark) {
    notifyListeners();
  }

  ThemeData getTheme(isDark) {
    return isDark ? darkTheme : lightTheme;
  }
}
