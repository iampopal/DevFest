import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest/data/assets.dart';
import 'package:devfest/data/sizes.dart';
import 'package:devfest/model/sponsor.dart';
import 'package:devfest/util/UrlUtil.dart';
import 'package:flutter/material.dart';

class SponsorWidet extends StatelessWidget {
  final Sponsor sponsor;
  SponsorWidet({this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () =>
            sponsor.link == null ? null : UrlUtil.launchURL(sponsor.link),
        borderRadius: BorderRadius.circular(Sizes.tabRound),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Theme.of(context).dividerColor)),
                padding: EdgeInsets.all(4),
                child: CachedNetworkImage(
                  imageUrl: sponsor.logoUrl,
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(width: 12),
              Text(
                sponsor.name,
                style:
                    Theme.of(context).textTheme.button.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
