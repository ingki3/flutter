import 'package:credit_card_sms_receiver/theme/hotelAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:credit_card_sms_receiver/model/hotelListData.dart';

class HotelListView extends StatelessWidget {
//  final VoidCallback callback;
  final HotelListData hotelData;

  const HotelListView({Key key, this.hotelData}) : super(key: key);
//  const HotelListView({Key key, this.hotelData, this.animationController, this.animation, this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    hotelData.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  hotelData.titleTxt,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData.subTxt,
                                      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      size: 12,
                                      color: HotelAppTheme.buildLightTheme().primaryColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${hotelData.dist.toStringAsFixed(1)} km to city",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: <Widget>[
                                      SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: hotelData.rating,
                                        size: 20,
                                        color: HotelAppTheme.buildLightTheme().primaryColor,
                                        borderColor: HotelAppTheme.buildLightTheme().primaryColor,
                                      ),
                                      Text(
                                        " ${hotelData.reviews} Reviews",
                                        style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, top: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "\$${hotelData.perNight}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "/per night",
                              style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: HotelAppTheme.buildLightTheme().primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
