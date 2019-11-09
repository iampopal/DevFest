import 'package:devfest/data/sizes.dart';
import 'package:devfest/model/person.dart';
import 'package:devfest/screen/person.dart';
import 'package:devfest/widget/photoHero.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  final Person person;
  final String asset;
  final Color accentColor;

  const PersonWidget({
    Key key,
    this.person,
    this.asset,
    this.accentColor,
  }) : super(key: key);
  final colorTime = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PersonScreen(
                  person: person,
                  asset: asset,
                  color: accentColor,
                ),
              ),
            );
          },
          child: Container(
            child: Stack(
              children: <Widget>[
                PhotoHeroWidget(
                  person: person,
                  asset: asset,
                  size: double.infinity,
                  radius: Sizes.cardRound,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.cardRound),
                    child: Opacity(
                      opacity: 0.75,
                      child: Container(
                        margin: EdgeInsets.all(asset != null ? 6 : 5.9),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.cardRound),
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          person.firstName,
                          style: Theme.of(context).textTheme.body1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          person.lastName,
                          style: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                        ),
                        Text(
                          person.position,
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
