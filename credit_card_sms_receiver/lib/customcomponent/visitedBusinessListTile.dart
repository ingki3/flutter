import 'package:credit_card_sms_receiver/model/visitedBusinessListTileData.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';


class VisitedBusinessListTile extends StatelessWidget {
//  final VoidCallback callback;
  final VisitedBusinessListTileData item;

  const VisitedBusinessListTile({Key key, this.item}) : super(key: key);
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
/*              AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    item.iconImagePath,
                    fit: BoxFit.cover,
                  ),
                ), */
                Container(
                  color: CustomAppTheme.buildLightTheme().backgroundColor,
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
                                  item.titleTxt,
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
                                      item.subTxt,
                                      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                    ),
                                  ],
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
                              "\$${item.perNight}",
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
          ],
        ),
      ),
    );
  }
}
