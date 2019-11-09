import 'package:devfest/data/assets.dart';
import 'package:devfest/data/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DevFest18Widget extends StatelessWidget {
  final String svgAsset;
  final String number;
  final String name;
  final Color color;

  const DevFest18Widget(
      {Key key, this.svgAsset, this.number, this.name, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blackColor = color;
    return Container(
      height: 170,
      width: 200,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.cardRound),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            SvgPicture.asset(
              svgAsset,
              width: 30,
              height: 30,
              color: blackColor,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              number,
              style: TextStyle(
                color: blackColor,
                fontSize: 68,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              name,
              style: TextStyle(color: blackColor, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
