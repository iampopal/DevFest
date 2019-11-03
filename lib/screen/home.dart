import 'package:devfest/data/assets.dart';
import 'package:devfest/page/sponsor.dart';
import 'package:devfest/provider/prefs.dart';
import 'package:devfest/page/agenda.dart';
import 'package:devfest/page/home.dart';
import 'package:devfest/page/person.dart';
import 'package:devfest/widget/navigationTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

enum NavigationTab { home, speaker, agenda, sponser, organizer, saawis, gdg }

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

  @override
  void initState() {
    super.initState();
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

  CustomScrollView _buildSliveList() {
    return CustomScrollView(slivers: <Widget>[
      // SliverAppBar(
      //   floating: true,
      //   snap: true,
      //   //pinned: true,
      //   backgroundColor: Colors.transparent,
      //   flexibleSpace: FlexibleSpaceBar(
      //     background: Image.asset(
      //       "assets/devfest.png",
      //     ),
      //   ),
      //   expandedHeight: 113,
      // ),
      SliverAppBar(
        flexibleSpace: FlexibleSpaceBar(
          background: _buildDevFestImage(context),
        ),
        expandedHeight: 113,
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          //_buildDevFestImage(),
          _buildNavigationButtons(),
          Container(
            height: 470,
            child: _buildPages(),
          )
        ]),
      )
    ]);
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
        width: 316,
        alignment: Alignment.center,
        child: Center(
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: getNavigationList(),
          ),
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

    final sponser = NavigationTabWidget(
      text: "Sponser",
      asset: Assets.svg.sponsors,
      color: Colors.amber,
      left: 135,
      visibleLeftIcon: _navigationTab == NavigationTab.sponser ||
          _navigationTab == NavigationTab.organizer,
      onTap: _onNavTap(NavigationTab.sponser),
      isCurrent: _navigationTab == NavigationTab.sponser,
      animation: _animation,
    );

    final speaker = NavigationTabWidget(
      text: "Speakers",
      asset: Assets.svg.speakers,
      color: Colors.green,
      left: 90,
      visibleLeftIcon: _navigationTab == NavigationTab.speaker ||
          _navigationTab == NavigationTab.sponser ||
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
          _navigationTab == NavigationTab.sponser ||
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
      sponser,
      speaker,
      agenda,
      home,
    ];

    switch (_navigationTab) {
      case NavigationTab.agenda:
        return [organizer, sponser, speaker, home, agenda];
      case NavigationTab.speaker:
        return [organizer, sponser, home, agenda, speaker];
      case NavigationTab.sponser:
        return [organizer, home, agenda, speaker, sponser];
      case NavigationTab.organizer:
        return [home, agenda, speaker, sponser, organizer];
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
        case NavigationTab.sponser:
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
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: PageView(
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
              _changeNav(NavigationTab.sponser);
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
      ),
    );
  }
}
