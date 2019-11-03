import 'package:devfest/data/assets.dart';
import 'package:devfest/provider/prefs.dart';
import 'package:devfest/provider/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ThemeSwitchWidget extends StatefulWidget {
  @override
  _ThemeSwitchWidgetState createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool _isBlackTheme = false;
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<PrefNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    _isBlackTheme = pref.isDarkTheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            Assets.svg.day_mode,
            width: 30,
            color: Colors.amber,
          ),
        ),
        CupertinoSwitch(
          activeColor: Colors.black,
          onChanged: (v) {
            setState(() {
              _isBlackTheme = v;
            });
            pref.changeTheme();
            theme.changeTheme(_isBlackTheme);
          },
          value: _isBlackTheme,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            Assets.svg.night_mode,
            width: 30,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
