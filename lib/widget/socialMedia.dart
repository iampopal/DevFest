import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaWidget extends StatelessWidget {
  final String asset;
  final Color color;
  SocialMediaWidget({
    Key key,
    this.asset,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 30;
    return Container(
      child: SvgPicture.asset(
        asset,
        width: size,
        height: size,
        color: color != null ? color : Theme.of(context).primaryIconTheme.color,
      ),
    );
  }
}
