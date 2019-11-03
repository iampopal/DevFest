import 'package:cloud_firestore/cloud_firestore.dart';

enum SponsorType { Genaral, Diamond, Platinum, Gold, Silver, Associated }

class Sponsor {
  final String name, link, logoUrl;
  final int level;
  final DocumentReference reference;

  static SponsorType sponsorType(Sponsor sponsor) {
    if (sponsor.level == null) return SponsorType.Genaral;
    switch (sponsor.level) {
      case 1:
        return SponsorType.Diamond;
      case 2:
        return SponsorType.Platinum;
      case 3:
        return SponsorType.Gold;
      case 4:
        return SponsorType.Silver;
      case 5:
        return SponsorType.Associated;
      default:
        return SponsorType.Genaral;
    }
  }

  Sponsor({
    this.name,
    this.level,
    this.link,
    this.logoUrl,
    this.reference,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "link": link,
        "level": level,
        "logoUrl": logoUrl,
      };

  Sponsor.fromMap(Map<String, dynamic> data, {this.reference})
      : name = data['name'],
        level = data['level'],
        logoUrl = data['logoUrl'],
        link = data['link'];

  Sponsor.fromFirestore(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
