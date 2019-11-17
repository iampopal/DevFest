import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/data/database.dart';
import 'package:devfest/data/sizes.dart';
import 'package:devfest/model/sponsor.dart';
import 'package:devfest/widget/sponsor.dart';
import 'package:flutter/material.dart';

class SponserPage extends StatelessWidget {
  const SponserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.firebase().collection("sponsor").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List<Sponsor> sponsorsList = snapshot.data.documents
            .map((data) => Sponsor.fromFirestore(data))
            .toList();

        return _buildSponsers(context, sponsorsList);
      },
    );
  }

  Widget _buildSponsers(BuildContext context, List<Sponsor> list) {
    List<Sponsor> generals = [],
        dimonds = [],
        platinums = [],
        goldens = [],
        silvers = [],
        associateds = [];

    for (final s in list) {
      switch (Sponsor.sponsorType(s)) {
        case SponsorType.Diamond:
          dimonds.add(s);
          break;

        case SponsorType.Gold:
          goldens.add(s);
          break;

        case SponsorType.Platinum:
          platinums.add(s);
          break;

        case SponsorType.Gold:
          goldens.add(s);
          break;

        case SponsorType.Silver:
          silvers.add(s);
          break;

        case SponsorType.Associated:
          associateds.add(s);
          break;

        default:
          generals.add(s);
      }
    }

    return Container(
      child: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          _buildSponsorsList(context, "General Sponsor", generals),
          _buildSponsorsList(context, "Diamond Sponsor", dimonds),
          _buildSponsorsList(context, "Platinum Sponsor", platinums),
          _buildSponsorsList(context, "Golden Sponsor", goldens),
          _buildSponsorsList(context, "Silver Sponsor", silvers),
          _buildSponsorsList(context, "Associated Partner", associateds),
        ],
      ),
    );
  }

  Widget _buildSponsorsList(
      BuildContext context, String sponsor, List<Sponsor> list) {
    return Visibility(
      visible: list.length > 0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(sponsor + (list.length > 1 ? 's' : ''),
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 11)),
              ),
            ),
            Column(
              children: List.generate(
                list.length,
                (i) => SponsorWidet(sponsor: list[i]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
