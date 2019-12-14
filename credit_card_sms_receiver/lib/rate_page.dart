import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:credit_card_sms_receiver/business_result.dart';
import 'package:credit_card_sms_receiver/customcomponent/custom_app_bar.dart';
import 'package:credit_card_sms_receiver/history_page.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'customcomponent/status_filter_chip.dart';

class RatePage extends StatefulWidget {

  final SearchResult result;
  final int itemIndex;

  RatePage({Key key, this.result, this.itemIndex});
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {

  final textEditingController = TextEditingController();
  String preference;
  String withWho;
  String comment;

  @override
  void initState() {
    this.preference = '3';
    this.withWho = "alone";
    this.comment = '내용을 입력하세요.';
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
                                        "누구와 함께 왔나요?",
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
                                        _getAccompanyList(),
                                      ],
                                    ),
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
                                        _getPreferenceList(),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "추가로 알려주실 내용 있으세요?",
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
                                  Container(
                                    child: TextField(
                                        controller: textEditingController,
                                        decoration: InputDecoration(hintText: this.comment),
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
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      child: Text("Rate!!", style: CustomAppTheme.dartGreyText,),
                      textColor: Colors.blue,
                      onPressed: (){
                        _rate().then((onValue){
                          Navigator.of(context).pop();
                          Navigator.push(context, 
                            MaterialPageRoute(builder:  (context) => HitoryPage())
                          );
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getPreferenceList() {
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
          if (this.preference == '5' ) {
            this.comment = "다른 사람들에게도 강력 추천!";
          }
          else if (this.preference == '4' ) {
            this.comment = "다시 방문 할 의향 있음.";
          }
          else if (this.preference == '3' ) {
            this.comment = "그럭 저럭 괜찮았음.";
          }
          else if (this.preference == '2' ) {
            this.comment = "일부러 다시 올 생각은 없음.";
          }
          else {
            this.comment = "완전 비추.";
          }
        });
      },
      hint: Text('Select Item'),
      value: this.preference,
    );
  }

  Widget _getAccompanyList() {
    return  DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text("혼자서"),
          value: 'alone',
        ),
        DropdownMenuItem<String>(
          child: Text("친구와 약속"),
          value: 'friends',
        ),
        DropdownMenuItem<String>(
          child: Text("비즈니스 때문에"),
          value: 'business'
        ),
        DropdownMenuItem<String>(
          child: Text("가족들과의 모임"),
          value: 'family',
        ),
        DropdownMenuItem<String>(
          child: Text("기타"),
          value: 'etc',
        ),
      ],
      onChanged: (value) {
        setState(() {
          this.withWho = value;
        });
      },
      hint: Text('Select Item'),
      value: this.withWho,
    );
  }

  Future _rate() async {
    var doc = Firestore.instance.collection('post').document();
    await doc.setData({
      'id':widget.result.resultItem[widget.itemIndex].id,
      'userId':userStatus.uid,
      'userEmail': userStatus.email,
      'userDisplayName': userStatus.displayName,
      'name':widget.result.resultItem[widget.itemIndex].name,
      'address': widget.result.resultItem[widget.itemIndex].address,
      'latitude': widget.result.resultItem[widget.itemIndex].latitude,
      'longitude': widget.result.resultItem[widget.itemIndex].longitude,
      'spending' :widget.result.msgMap["spending"],
//      'year': widget.result.msgMap["year"],
//      'month': widget.result.msgMap["month"],
//      'day': widget.result.msgMap["day"],
//      'hour': widget.result.msgMap["hour"],
//      'minute': widget.result.msgMap["minute"],
      'visitedTime' : '${widget.result.msgMap["year"]}-${widget.result.msgMap["month"]}-${widget.result.msgMap["day"]} ${widget.result.msgMap["hour"]}:${widget.result.msgMap["minute"]}',
      'currentTime': DateTime.now(),
      'rating' : double.parse(this.preference),
      'with' : this.withWho,
    });
  }
}