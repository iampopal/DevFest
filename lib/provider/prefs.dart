import 'package:devfest/data/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefNotifier with ChangeNotifier {
  SharedPreferences pref;
  PrefNotifier({this.pref});

  Future<PrefNotifier> instance() async {
    pref = await SharedPreferences.getInstance();
    return PrefNotifier(pref: pref);
  }

  bool get isDarkTheme => pref.getBool(Keys.blckTheme) ?? false;

  changeTheme() {
    var changedTheme = pref.setBool(Keys.blckTheme, !isDarkTheme);
    notifyListeners();
    return changedTheme;
  }
}
