import 'package:devfest/data/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationTabWidget extends AnimatedWidget {
  final String asset;
  final String text;
  final MaterialColor color;
  final bool visibleLeftIcon;
  final double left;
  final Function onTap;
  final bool isCurrent;

  NavigationTabWidget({
    Key key,
    this.asset,
    this.text,
    this.color,
    this.visibleLeftIcon = false,
    this.left,
    this.onTap,
    this.isCurrent,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    final leftTween =
        Tween<double>(begin: left - 50, end: left).evaluate(animation);

    return Positioned(
      top: 0,
      bottom: 0,
      left: !isCurrent ? left : leftTween,
      child: Container(
        width: 150,
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.tabRound),
            side: BorderSide(
                color: Color.fromARGB(40, 0, 0, 0),
                width: 2,
                style: BorderStyle.solid)),
        color: color,
        child: Row(
          mainAxisAlignment:
              visibleLeftIcon ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            Visibility(visible: visibleLeftIcon, child: _buildIcon()),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Visibility(
              visible: !visibleLeftIcon,
              child: _buildIcon(),
            ),
          ],
        ),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildIcon() {
    final double padding = 5.0;
    return Padding(
      padding: EdgeInsets.only(
          left: visibleLeftIcon ? 0 : padding,
          right: visibleLeftIcon ? padding : 0),
      child: SizedBox(
        width: 26,
        height: 26,
        child: SvgPicture.asset(
          asset,
          color: Colors.white,
        ),
      ),
    );
  }
}
