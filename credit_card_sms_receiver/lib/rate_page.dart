//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/theme/designCourseAppTheme.dart';
import 'package:credit_card_sms_receiver/theme/hotelAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
      appBar: AppBar(),
      body: _getRatePage()
    );
  }

  Widget _getRatePage() {
    return Column(
      children: <Widget>[
        Column(
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
                                  style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
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
                                    rating: 3.5,
                                    size: 20,
                                    color: CustomAppTheme.buildLightTheme().primaryColor,
                                    borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                                  ),
                                  Text(
                                    " 7 Reviews",
                                    style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              child: Text("Yes, I'm Here. I want to Rate!!", style: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.bold),),
                              textColor: Colors.blue,
                              onPressed: (){},
                            )
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
              child: Row(
                children: <Widget>[
                  getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
                  SizedBox(
                    width: 16,
                  ),
                  getButtonUI(
                      CategoryType.coding, categoryType == CategoryType.coding),
                  SizedBox(
                    width: 16,
                  ),
                  getButtonUI(
                      CategoryType.basic, categoryType == CategoryType.basic),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }


  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    var txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: new BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            border: new Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}

enum CategoryType {
  ui,
  coding,
  basic,
}