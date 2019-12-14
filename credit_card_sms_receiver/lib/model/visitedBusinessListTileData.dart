import 'package:cloud_firestore/cloud_firestore.dart';

class VisitedBusinessListTileData {
  String id;
  String address;
  String iconImagePath;
  String name;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  String spending;
  double latitude;
  double longitude;
  String withWho;
  String comment;

  VisitedBusinessListTileData(DocumentSnapshot document) {
    this.id = document['id'];
    this.address = document['address'];
    this.iconImagePath = document['iconImagePath'];
    this.name = document['name'];
    this.subTxt = document['visitedTime'];
    this.dist = 1.8;
    this.reviews = 8;
    this.rating = document['rating'];
    this.spending = document['spending'];
    this.latitude = document["latitude"];
    this.longitude = document["longitude"];
    this.withWho = document["with"];
    this.comment = (document["comment"]==null)
              ? "no comment"
              : document["comment"];
  }
}
