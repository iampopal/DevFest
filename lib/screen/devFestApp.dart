import 'package:devfest/provider/prefs.dart';
import 'package:devfest/provider/theme.dart';
import 'package:devfest/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DevFestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
      providers: [
        FutureProvider.value(value: PrefNotifier().instance()),
        ChangeNotifierProvider.value(value: ThemeNotifier()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefNotifier = Provider.of<PrefNotifier>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final brigtness =
        prefNotifier.isDarkTheme ? Brightness.light : Brightness.dark;

    //Set Colors
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            themeNotifier.getTheme(prefNotifier.isDarkTheme).cardColor,
        systemNavigationBarIconBrightness: brigtness,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brigtness,
      ),
    );

    //set Oriantation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(prefNotifier.isDarkTheme),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
