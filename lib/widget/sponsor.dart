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
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: FlatButton(
        onPressed: () => UrlUtil.launchURL(sponsor.link),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
        padding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Theme.of(context).dividerColor)),
                padding: EdgeInsets.all(4),
                width: 55,
                height: 55,
                child: CachedNetworkImage(
                  imageUrl: sponsor.logoUrl,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.contain,
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
