import 'package:devfest/data/assets.dart';
import 'package:devfest/provider/prefs.dart';
import 'package:devfest/data/sizes.dart';
import 'package:devfest/provider/theme.dart';
import 'package:devfest/screen/about.dart';
import 'package:devfest/util/UrlUtil.dart';
import 'package:devfest/widget/socialMedia.dart';
import 'package:devfest/widget/themeSwitch.dart';
import 'package:devfest/widget/timeOut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Expanded(child: _buildMainCard(context)),
          SizedBox(height: 4),
          _buildApply(context),
          SizedBox(height: 2),
          buildNavigateUp(context)
        ],
      ),
    );
  }

  Widget buildNavigateUp(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (d) {
        _showBottomSheet(context);
      },
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: 34,
        child: SizedBox(
          height: 12,
          child: SvgPicture.asset(
            Assets.svg.chevron_up,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.cardRound),
          topRight: Radius.circular(Sizes.cardRound),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 140,
          padding: EdgeInsets.only(top: 21),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              ThemeSwitchWidget(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 60, right: 60, top: 12, bottom: 6),
                child: Divider(height: 10),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
                },
                splashColor: Colors.amber,
                borderRadius: BorderRadius.circular(Sizes.cardRound),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        Assets.svg.about_us,
                        color: Theme.of(context).primaryIconTheme.color,
                        width: 18,
                      ),
                      Text(
                        "About us",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildApply(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: InkWell(
        splashColor: Colors.amber,
        borderRadius: BorderRadius.circular(28),
        onTap: () => UrlUtil.launchURL(
            "https://docs.google.com/forms/d/e/1FAIpQLSfCY3nNYL049qmHFIcppMVMUWHpZKCUXt5iozpliLgahssazA/viewform?usp=send_form"),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 11),
          child: Text(
            "Apply",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.cardRound),
              side: BorderSide(
                  width: Sizes.borderWidth,
                  color: Theme.of(context).dividerColor),
            ),
            child: Column(
              children: <Widget>[
                //_buildHead(context),
                _buildDescriptionText(),
                _buildSocialIcons()
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 62,
          child: TimeOutWidget(),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 4,
        right: 4,
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () => UrlUtil.launchFacebook("gdgkabul"),
              icon: SocialMediaWidget(asset: Assets.svg.facebook),
            ),
            IconButton(
                onPressed: () => UrlUtil.launchTwitter("gdg_kabul"),
                icon: SocialMediaWidget(asset: Assets.svg.twitter)),
            IconButton(
                onPressed: () => UrlUtil.launchMeetUp(),
                icon: SocialMediaWidget(asset: Assets.svg.meetup)),
            IconButton(
                onPressed: () => UrlUtil.launchEmail("gdgkabul@gmail.com"),
                icon: SocialMediaWidget(asset: Assets.svg.email)),
            IconButton(
                onPressed: () => UrlUtil.launchTel("+93731913693"),
                icon: SocialMediaWidget(asset: Assets.svg.telephone)),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
      child: Text(
        "DevFests are community-led developer events hosted by Google Developer Groups around the globe. GDG DevFest Kabul 2019 is the biggest developer festival organized by GDG kabul. We create DevFest Kabul 2019 to be the best place for experience sharing in a wonderful and comfortable atmosphere. DevFest Kabul 2019 will bring together experts in Web, Android, AI and cloud technologies from all around Afghanistan and neighboring countries.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildHead(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, left: 21),
      child: Row(
        children: <Widget>[
          Image.asset(
            Assets.img.popalProfile,
            width: 50,
          ),
          SizedBox(width: 8),
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}
