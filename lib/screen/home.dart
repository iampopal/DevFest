import 'package:devfest/data/assets.dart';
import 'package:devfest/page/sponsor.dart';
import 'package:devfest/provider/prefs.dart';
import 'package:devfest/page/agenda.dart';
import 'package:devfest/page/home.dart';
import 'package:devfest/page/person.dart';
import 'package:devfest/widget/navigationTab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum NavigationTab { home, speaker, agenda, sponsor, organizer, saawis, gdg }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  NavigationTab _navigationTab;
  PageController _pageController;

  AnimationController _animationController;
  Animation<double> _animation;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  showNotification({String title, String body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      color: Colors.blue,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      // style: AndroidNotificationStyle.BigText,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: "payload1");
  }

  initNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  Future onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    print("onDidReceiveLocalNotification: $id");
  }

  Future onSelectNotification(String payload) {
    print("payLoad: $payload");
  }

  void initMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          print("initMessaging onMessage: $message");
        });
        showNotification(
          title: message['notification']['title'],
          body: message['notification']['body'],
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          print("initMessaging onLaunch");
        });
        showNotification(
          title: message['notification']['title'],
          body: message['notification']['body'],
        );
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          print("initMessaging on Resume...");
        });
        showNotification(
          title: message['notification']['title'],
          body: message['notification']['body'],
        );
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        print("Push Messaging token: $token");
      });
      print("Ahmmm...");
    });
  }

  @override
  void initState() {
    super.initState();
    initMessaging();
    initNotification();
    _pageController = PageController(initialPage: 0, keepPage: false);
    _navigationTab = NavigationTab.home;

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation =
        CurvedAnimation(curve: Curves.ease, parent: _animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {}
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  _buildHome(BuildContext context) {
    return Column(children: <Widget>[
      _buildDevFestImage(context),
      _buildNavigationButtons(),
      Expanded(child: _buildPages())
    ]);
  }

  _buildDevFestImage(BuildContext context) {
    final pref = Provider.of<PrefNotifier>(context);

    return Container(
      width: double.infinity,
      height: 136,
      child: Image.asset(
        pref.isDarkTheme ? Assets.img.devFestNight : Assets.img.devFestDay,
      ),
    );
  }

  _buildNavigationButtons() {
    return Center(
      child: Container(
        height: 54,
        width: 330,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: getNavigationList(),
        ),
      ),
    );
  }

  getNavigationList() {
    final organizer = NavigationTabWidget(
      text: "Organizers",
      asset: Assets.svg.organizer,
      color: Colors.red,
      left: 180,
      visibleLeftIcon: _navigationTab == NavigationTab.organizer,
      onTap: _onNavTap(NavigationTab.organizer),
      isCurrent: _navigationTab == NavigationTab.organizer,
      animation: _animation,
    );

    final sponsor = NavigationTabWidget(
      text: "Sponsors",
      asset: Assets.svg.sponsors,
      color: Colors.amber,
      left: 135,
      visibleLeftIcon: _navigationTab == NavigationTab.sponsor ||
          _navigationTab == NavigationTab.organizer,
      onTap: _onNavTap(NavigationTab.sponsor),
      isCurrent: _navigationTab == NavigationTab.sponsor,
      animation: _animation,
    );

    final speaker = NavigationTabWidget(
      text: "Speakers",
      asset: Assets.svg.speakers,
      color: Colors.green,
      left: 90,
      visibleLeftIcon: _navigationTab == NavigationTab.speaker ||
          _navigationTab == NavigationTab.sponsor ||
          _navigationTab == NavigationTab.organizer,
      onTap: _onNavTap(NavigationTab.speaker),
      isCurrent: _navigationTab == NavigationTab.speaker,
      animation: _animation,
    );

    final agenda = NavigationTabWidget(
      text: "Agenda",
      asset: Assets.svg.agenda,
      color: Colors.red,
      left: 45,
      visibleLeftIcon: _navigationTab == NavigationTab.agenda ||
          _navigationTab == NavigationTab.speaker ||
          _navigationTab == NavigationTab.sponsor ||
          _navigationTab == NavigationTab.organizer,
      onTap: _onNavTap(NavigationTab.agenda),
      isCurrent: _navigationTab == NavigationTab.agenda,
      animation: _animation,
    );

    Widget home = NavigationTabWidget(
      text: "Home",
      asset: Assets.svg.home,
      color: Colors.blue,
      visibleLeftIcon: true,
      left: 0,
      onTap: _onNavTap(NavigationTab.home),
      isCurrent: _navigationTab == NavigationTab.home,
      animation: _animation,
    );

    final homeItems = [
      organizer,
      sponsor,
      speaker,
      agenda,
      home,
    ];

    switch (_navigationTab) {
      case NavigationTab.agenda:
        return [organizer, sponsor, speaker, home, agenda];
      case NavigationTab.speaker:
        return [organizer, sponsor, home, agenda, speaker];
      case NavigationTab.sponsor:
        return [organizer, home, agenda, speaker, sponsor];
      case NavigationTab.organizer:
        return [home, agenda, speaker, sponsor, organizer];
      default:
        return homeItems;
    }
  }

  _onNavTap(NavigationTab nav) {
    return () {
      switch (nav) {
        case NavigationTab.agenda:
          _pageController.jumpToPage(1);
          break;
        case NavigationTab.speaker:
          _pageController.jumpToPage(2);
          break;
        case NavigationTab.sponsor:
          _pageController.jumpToPage(3);
          break;
        case NavigationTab.organizer:
          _pageController.jumpToPage(4);
          break;
        default:
          _pageController.jumpToPage(0);
          break;
      }
      _changeNav(nav);
    };
  }

  void _changeNav(NavigationTab nav) {
    setState(() {
      _navigationTab = nav;
      _animationController.forward(from: 0.5);
    });
  }

  Widget _buildPages() {
    return PageView(
      controller: _pageController,
      onPageChanged: (p) {
        switch (p) {
          case 1:
            _changeNav(NavigationTab.agenda);
            break;
          case 2:
            _changeNav(NavigationTab.speaker);
            break;
          case 3:
            _changeNav(NavigationTab.sponsor);
            break;
          case 4:
            _changeNav(NavigationTab.organizer);
            break;
          default:
            _changeNav(NavigationTab.home);
        }
      },
      children: <Widget>[
        HomePage(),
        AgendaPage(),
        PersonPage(
          personType: PersonType.speaker,
        ),
        SponserPage(),
        PersonPage(
          personType: PersonType.organizer,
        ),
      ],
    );
  }
}
