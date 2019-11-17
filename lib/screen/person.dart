import 'package:devfest/data/assets.dart';
import 'package:devfest/data/sizes.dart';
import 'package:devfest/model/person.dart';
import 'package:devfest/provider/prefs.dart';
import 'package:devfest/util/UrlUtil.dart';
import 'package:devfest/widget/backButton.dart';
import 'package:devfest/widget/photoHero.dart';
import 'package:devfest/widget/socialMedia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({
    this.person,
    this.asset,
    this.color,
    Key key,
  }) : super(key: key);

  final Person person;
  final String asset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTitleStack(context),
          SizedBox(height: 12),
          _buildSocialLinks(context),
          SizedBox(height: 16),
          SizedBox(
            width: 300,
            child: Text(person.bio ?? ""),
          ),
        ],
      ),
    );
  }

  Stack _buildTitleStack(BuildContext context) {
    final pref = Provider.of<PrefNotifier>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 306,
          child: Image.asset(pref.isDarkTheme
              ? Assets.img.profileCoverNight
              : Assets.img.profileCoverDay),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 0),
              child: SafeArea(child: BackButtonWidget()),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  _buildPicture(),
                  SizedBox(height: 8),
                  Text(
                    person.firstName + " " + person.lastName,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Text(
                    person.position,
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPicture() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: PhotoHeroWidget(
          asset: asset,
          person: person,
          size: 160,
          radius: 160 / 2,
        ),
      ),
    );
  }

  _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSocialWidget(
            context: context,
            assetSvg: Assets.svg.facebook,
            name: "Facebook",
            visibility: person.facebook != null,
            onTap: () => UrlUtil.launchFacebook(person.facebook)),
        _buildSocialWidget(
          context: context,
          assetSvg: Assets.svg.twitter,
          name: "Twitter",
          visibility: person.twitter != null,
          onTap: () => UrlUtil.launchTwitter(person.twitter),
        ),
        _buildSocialWidget(
          context: context,
          assetSvg: Assets.svg.instagram,
          name: "Instagram",
          visibility: person.instagram != null,
          onTap: () => UrlUtil.launchInstagram(person.instagram),
        ),
        _buildSocialWidget(
          context: context,
          assetSvg: Assets.svg.gitHub,
          name: "GitHub",
          visibility: person.gitHub != null,
          onTap: () => UrlUtil.launchGitHub(person.gitHub),
        ),
        _buildSocialWidget(
          context: context,
          assetSvg: Assets.svg.web,
          name: "Website",
          visibility: person.website != null,
          onTap: () => UrlUtil.launchURL(person.website),
        ),
      ],
    );
  }

  Widget _buildSocialWidget(
      {BuildContext context,
      String assetSvg,
      String name,
      Function onTap,
      bool visibility}) {
    return Visibility(
      visible: visibility ?? false,
      child: InkWell(
        borderRadius: BorderRadius.circular(Sizes.cardRound),
        onTap: onTap,
        child: SizedBox(
          width: 85,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocialMediaWidget(
                asset: assetSvg,
                color: color,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: color,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
