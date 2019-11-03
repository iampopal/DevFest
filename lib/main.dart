import 'package:devfest/provider/theme.dart';
import 'package:devfest/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/prefs.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      providers: [
        FutureProvider.value(value: PrefNotifier().instance()),
        ChangeNotifierProvider.value(value: ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefNotifier = Provider.of<PrefNotifier>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              prefNotifier.isDarkTheme ? Brightness.light : Brightness.dark),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(prefNotifier.isDarkTheme),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
