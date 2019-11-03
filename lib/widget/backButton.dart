import 'package:devfest/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Padding(
        padding: const EdgeInsets.all(0),
        child: RotatedBox(
          quarterTurns: 3,
          child: SvgPicture.asset(
            Assets.svg.chevron_up,
            width: 26,
            height: 26,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
