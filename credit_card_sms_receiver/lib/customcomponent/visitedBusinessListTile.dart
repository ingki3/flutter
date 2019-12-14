import 'package:credit_card_sms_receiver/model/visitedBusinessListTileData.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';

class VisitedBusinessListTile extends StatelessWidget {
  final VisitedBusinessListTileData item;

  const VisitedBusinessListTile({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomAppTheme.buildLightTheme().backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0)
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.subTxt,
                    style: CustomAppTheme.greyText,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _getWith(),
                      style: CustomAppTheme.greyText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0)
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0)
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.name,
                    textAlign: TextAlign.left,
                    style: CustomAppTheme.mainLabel,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${item.spending}",
                      textAlign: TextAlign.left,
                      style: CustomAppTheme.mainLabel,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0)
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:8.0, right: 8.0),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      _getRating(),
                      style: CustomAppTheme.greyText,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:8.0, right: 8.0, top: 2.0),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      item.comment,
                      style: CustomAppTheme.greyText,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getWith() {
    if (item.withWho == 'alone') {
      return "혼자서";
    }
    else if (item.withWho == 'friends') {
      return "친구와";
    }
    else if (item.withWho == 'business') {
      return "사업상 모임으로";
    }
    else if (item.withWho == 'family') {
      return "가족과";
    }
    else {
      return "어느 누군가와";
    }
  }

  String _getRating() {
    if (item.rating == 5 ) {
      return "다른 사람들에게도 강력 추천!(★★★★★)";
    }
    else if (item.rating == 4 ) {
      return "다시 방문 할 의향 있음.(★★★★☆)";
    }
    else if (item.rating == 3 ) {
      return "그럭 저럭 괜찮았음.(★★★☆☆)";
    }
    else if (item.rating == 2 ) {
      return "일부러 다시 올 생각은 없음.(★★☆☆☆)";
    }
    else {
      return "완전 비추.(★☆☆☆☆)";
    }
  }

}

