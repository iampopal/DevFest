import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest/model/person.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PhotoHeroWidget extends StatelessWidget {
  const PhotoHeroWidget(
      {Key key,
      @required this.person,
      @required this.asset,
      @required this.size,
      @required this.radius})
      : clipRectSize = 2.0 * (size / math.sqrt2),
        super(key: key);

  final Person person;
  final String asset;
  final double size;
  final double radius;
  final clipRectSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Hero(
        tag: person.firstName + person.lastName,
        child: Card(
          margin: EdgeInsets.all(6),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          clipBehavior: Clip.antiAlias,
          child: asset == null
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: person.picUrl ?? "",
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return _buildEmptyPerson();
                  },
                )
              : Image.asset(
                  asset,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyPerson() {
    return Icon(
      Icons.person,
      size: 40,
    );
  }
}
