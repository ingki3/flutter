//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/customcomponent/custom_app_bar.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'customcomponent/status_filter_chip.dart';

class RatePage extends StatefulWidget {

//  final DocumentSnapshot item;

//  RatePage({Key key, this.item});
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {

  CategoryType categoryType = CategoryType.ui;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getRatePage()
    );
  }

  Widget _getRatePage() {
    return Theme(
      data: CustomAppTheme.buildLightTheme(),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            title: "Rate"
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                                    "스타벅스",
  //                                  widget.item["name"],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.all(8.0)
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "경기도 성남시 분당구...",
  //                                      widget.item["address"],
                                        style: CustomAppTheme.greyText,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        size: 12,
                                        color: CustomAppTheme.buildLightTheme().primaryColor,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "8 km to city",
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomAppTheme.greyText,
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
                                          rating: 3.5,
                                          size: 20,
                                          color: CustomAppTheme.buildLightTheme().primaryColor,
                                          borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                                        ),
                                        Text(
                                          " 7 Reviews",
                                          style: CustomAppTheme.greyText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: _getChipList(),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                          child: SmoothStarRating(
                            allowHalfRating: true,
                            onRatingChanged: (v) {
                              setState(() {

                              });
                            },
                            starCount: 5,
                            rating: 0,
                            size: 40.0,
                            color: CustomAppTheme.buildLightTheme().primaryColor,
                            borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                            spacing:0.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text("Rate!!", style: CustomAppTheme.dartGreyText,),
                          textColor: Colors.blue,
                          onPressed: (){},
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  List<Widget> _getChipList() {
    List<String> labels = ["편안함", "깨끗함", "친절함", "새로 만든", "아늑한", "새련된"];
    List<Widget> result = [];

    for (String label in labels) {
      result.add( StatusFilterChip(label:label));
    }

    return result;
  }
}



enum CategoryType {
  ui,
  coding,
  basic,
}