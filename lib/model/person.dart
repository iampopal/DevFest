import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String firstName, lastName, position, bio, picUrl;
  final String facebook, twitter, gitHub, instagram, linkedIn, email, website;
  final int job;

  final DocumentReference reference;

  Person({
    this.firstName,
    this.lastName,
    this.picUrl,
    this.position,
    this.bio,
    this.facebook,
    this.twitter,
    this.gitHub,
    this.instagram,
    this.linkedIn,
    this.email,
    this.website,
    this.job,
    this.reference,
  });

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "position": position,
        "bio": bio,
        "picUrl": picUrl,
        "facebook": facebook,
        "twitter": twitter,
        "gitHub": gitHub,
        "instagram": instagram,
        "linkedIn": linkedIn,
        "email": email,
        "website": website,
        "job": job.toInt(),
      };

  Person.fromMap(Map<String, dynamic> data, {this.reference})
      : firstName = data['firstName'],
        lastName = data["lastName"],
        position = data["position"],
        bio = data["bio"],
        picUrl = data["picUrl"],
        facebook = data["facebook"],
        twitter = data["twitter"],
        gitHub = data["gitHub"],
        instagram = data["instagram"],
        linkedIn = data["gitHub"],
        email = data["linkedIn"],
        website = data["website"],
        job = data["job"];

  Person.fromFirestore(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
