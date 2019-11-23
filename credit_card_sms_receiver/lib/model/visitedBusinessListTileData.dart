import 'package:cloud_firestore/cloud_firestore.dart';

class VisitedBusinessListTileData {
  String iconImagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  VisitedBusinessListTileData(DocumentSnapshot document) {
    this.iconImagePath = document['iconImagePath'];
    this.titleTxt = document['name'];
    this.subTxt = document['currentTime'].toDate().toString();
    this.dist = 1.8;
    this.reviews = 8;
    this.rating = document['rating'];
    this.perNight = 180;
  }


/*
  static List<HotelListData> hotelList = [
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_2.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_3.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_4.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_5.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
*/
}
