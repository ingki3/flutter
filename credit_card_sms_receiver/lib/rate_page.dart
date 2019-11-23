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
  final textEditingController = TextEditingController();
  String preference;

  @override
  void initState() {
    this.preference = '3';
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
                                        "이 곳에서 어땠나요?",
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
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: <Widget>[
                                        _getPrefenceList(),
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
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(hintText: '내용을 입력하세요.'),
                      ),
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

  Widget _getPrefenceList() {
    return  DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text("다른 사람들에게도 강력 추천!(★★★★★)"),
          value: '5',
        ),
        DropdownMenuItem<String>(
          child: Text("다시 방문 할 의향 있음.(★★★★☆)"),
          value: '4',
        ),
        DropdownMenuItem<String>(
          child: Text("그럭 저럭 괜찮았음.(★★★☆☆)"),
          value: '3'
        ),
        DropdownMenuItem<String>(
          child: Text("일부러 다시 올 생각은 없음.(★★☆☆☆)"),
          value: '2',
        ),
        DropdownMenuItem<String>(
          child: Text("완전 비추.(★☆☆☆☆)"),
          value: '1',
        ),
      ],
      onChanged: (value) {
        setState(() {
          this.preference = value;
        });
      },
      hint: Text('Select Item'),
      value: this.preference,
    );
  }

}





enum CategoryType {
  ui,
  coding,
  basic,
}