import 'package:devfest/data/assets.dart';
import 'package:devfest/model/person.dart';
import 'package:devfest/screen/home.dart';
import 'package:devfest/util/UrlUtil.dart';
import 'package:devfest/widget/backButton.dart';
import 'package:devfest/widget/navigationTab.dart';
import 'package:devfest/widget/person.dart';
import 'package:devfest/widget/socialMedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  NavigationTab _navigationTab;
  PageController _pageController;

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    _navigationTab = NavigationTab.saawis;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildAppbar(context),
            Expanded(child: _buildPages(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: <Widget>[
          BackButtonWidget(),
          SizedBox(
            width: 300,
            height: 54,
            child: Container(
              child: Stack(
                children: _buildNavigationList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildNavigationList() {
    final saawisTab = NavigationTabWidget(
      animation: _animation,
      asset: Assets.svg.saawis,
      color: Colors.blue,
      isCurrent: _navigationTab == NavigationTab.saawis,
      left: 40,
      onTap: _onNavTap(NavigationTab.saawis),
      text: "Saawis",
      visibleLeftIcon: true,
    );

    final gdgTab = NavigationTabWidget(
      animation: _animation,
      asset: Assets.svg.gdg,
      color: Colors.red,
      isCurrent: _navigationTab == NavigationTab.gdg,
      left: 85,
      onTap: _onNavTap(NavigationTab.gdg),
      text: "GDG Kabul",
      visibleLeftIcon: _navigationTab != NavigationTab.saawis,
    );

    final saawis = [
      gdgTab,
      saawisTab,
    ];
    final gdgKabul = [
      saawisTab,
      gdgTab,
    ];

    if (_navigationTab == NavigationTab.saawis) {
      return saawis;
    } else {
      return gdgKabul;
    }
  }

  _onNavTap(NavigationTab nav) {
    return () {
      switch (nav) {
        case NavigationTab.gdg:
          _pageController.jumpToPage(1);
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

  Widget _buildPages(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (p) {
        switch (p) {
          case 1:
            _changeNav(NavigationTab.gdg);
            break;
          default:
            _changeNav(NavigationTab.saawis);
            break;
        }
      },
      children: <Widget>[_buildSaawisPage(), _buildGdgPage()],
    );
  }

  Widget _buildSaawisPage() {
    final textStyle = Theme.of(context).textTheme.body1;
    return Column(
      children: <Widget>[
        SizedBox(height: 18),
        Text("DevFest Kabul 2019", style: textStyle),
        Text("Version 1.0", style: textStyle),
        SizedBox(height: 46),
        SvgPicture.asset(
          Assets.svg.gift,
          width: 50,
        ),
        SizedBox(
          width: 260,
          child: Text(
            "DevFest Kabul 2019 app is developed by Saawis to support DevFest Kabul 2019. It is developed using Flutter and Firebase as an open-source project. You can find the source code here.",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PersonWidget(
              asset: Assets.img.popalProfile,
              accentColor: Colors.blue,
              person: Person(
                  firstName: "Abdurahman",
                  lastName: "Popal",
                  position: "Sofware Engineer",
                  bio:
                      "Abdurahman popal is Computer Science student at Aria University and Mobile Developer at Saawis and passionate about developing native apps using dart and flutter."),
            ),
            PersonWidget(
              asset: Assets.img.ratibProfile,
              accentColor: Colors.blue,
              person: Person(
                  firstName: "Rateb",
                  lastName: "Ghiasy",
                  position: "Ui & UX Designer",
                  bio:
                      "Rateb Ghiasy is a computer science student in Aria University and a software UI and UX designer in Saawis Software Development Company. The DevFest 2019 event is his first event as a GDG co-organizer."),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGdgPage() {
    final textStyle = Theme.of(context).textTheme.body1;

    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        SizedBox(
          width: 300,
          child: Text(
            "DevFest Kabul 2019 app is developed by Saawis, our daimond sponsor and associate partner.",
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSocialLink(
              svgAsset: Assets.svg.facebook,
              link: "/gdgkabul",
              onTap: () => UrlUtil.launchFacebook("gdgkabul"),
            ),
            _buildSocialLink(
                svgAsset: Assets.svg.email,
                link: "gdgkabul@gmail.com",
                onTap: () => UrlUtil.launchEmail("gdgkabul@gmail.com")),
            _buildSocialLink(
                svgAsset: Assets.svg.twitter,
                link: "gdg_kabul",
                onTap: () => UrlUtil.launchTwitter("gdg_kabul")),
            _buildSocialLink(
              svgAsset: Assets.svg.meetup,
              link: "gdg-kabul",
              onTap: () => UrlUtil.launchMeetUp(),
            ),
            _buildSocialLink(
                svgAsset: Assets.svg.web,
                link: "www.gdgkabul.com",
                onTap: () => UrlUtil.launchURL("http://gdgkabul.com")),
          ],
        ),
      ],
    );
  }

  _buildSocialLink({String svgAsset, String link, Function onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SocialMediaWidget(asset: svgAsset),
            SizedBox(width: 4),
            Text(link, style: Theme.of(context).textTheme.body1)
          ],
        ),
      ),
    );
  }
}
