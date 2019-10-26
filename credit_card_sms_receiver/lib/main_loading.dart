import 'package:credit_card_sms_receiver/business_result.dart';
import 'package:credit_card_sms_receiver/business_select_page.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoadingPage extends StatefulWidget {
  final String msg;
  LoadingPage(this.msg);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isFinished = false;

  @override
  void initState() {
    super.initState();

    readingMessage(widget.msg);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(80)),
          Expanded(
            child: Container(
              child: Text("Loading"),
            ),
          ),
          Padding(padding: EdgeInsets.all(80)),
        ],
      ),
    );
  }

  Future readingMessage(String msg) async {
//    Map<String, String> parseResult = _parseString(widget.msg);
  
    setState(() {
    _getPosition(widget.msg).then((position){
      print(position.toString());

      Navigator.push(context, 
        MaterialPageRoute(builder:  (context) => BusinessSelectPage(position))
      );
    });
  });
  }

  Map<String, String> _parseString(String msg) {
    return _parseBCCard(msg);
  }

  Map<String, String> _parseBCCard(String str) {
    List<String> splitedStr = str.split('\n');
    for(var n in splitedStr) {
      print(n);
    }

    String cardName = splitedStr[1].substring(0, splitedStr[1].indexOf('('));
    print("Card Name : $cardName");
    String spending = splitedStr[3].substring(0, splitedStr[3].indexOf('원'));
    print("Spending : $spending");
    String month = spending = splitedStr[4].substring(0, splitedStr[4].indexOf('/'));
    String day = spending = splitedStr[4].substring(splitedStr[4].indexOf('/') + 1, splitedStr[4].indexOf(' '));
    String hour = spending = splitedStr[4].substring(splitedStr[4].indexOf(' ') + 1, splitedStr[4].indexOf(':'));
    String minute = spending = splitedStr[4].substring(splitedStr[4].indexOf(':') + 1, splitedStr[4].length);
    print("$month/$day $hour:$minute");
    String business = splitedStr[5];

    Map<String, String> map = {
          "cardName" : "$cardName",
          "Spending" : "$spending",
          "month" : "$month",
          "day" : "$day",
          "hour" : "$hour",
          "minute" : "$minute",
          "business" : "$business"
    };
    print("Business : ${map["business"]}");
      
    return map;
  }

  Future _getPosition(String msg) async {
    Map<String, String> parsedList = _parseString(msg);
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    String url =
        '''https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyC9kSjaT9qIaGcNBrQifVb-TRmr64VeBtU&location=${position.latitude},${position.longitude}&radius=1000&keyword=${parsedList["business"]}&language=kr''';
    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Mark 2-1 ***************************");
      var itemList = json.decode(response.body);

      List<BusinessResult> resultList = List();

      for(var item in itemList["results"]){
//        print(item);
        resultList.add(BusinessResult.fromJson(item));
        print(item["name"]);
        print(item["vicinity"]);
      }

      return SearchResult(parsedList["business"], position.latitude, position.longitude, resultList);


    }
    else{
      return null;
    }
  }


}