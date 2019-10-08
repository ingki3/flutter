import 'package:credit_card_sms_receiver/business_select_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:credit_card_sms_receiver/business_result.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class SmsInputPage extends StatefulWidget {
  @override
  _SmsInputPageState createState() => _SmsInputPageState();
}

class _SmsInputPageState extends State<SmsInputPage> {
  final _controller = TextEditingController();

  Map<String, double> userLocation;
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      final text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(
            baseOffset: text.length,
            extentOffset: text.length
        ),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
            
          );
        }
  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.brown,
            child: Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
          Container(
            color: Colors.cyan,
            child: Text('Input SMS Mesaage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.brown,
            child: Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ),
          Container(
            color: Colors.brown,
            child: Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
          Container(
            color: Colors.brown,
            child: RaisedButton(
              child: Text('Input SMS', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: () {
                Map<String, String> parseResult = _parseString();
                print("Business Name : ${parseResult["business"]}");

                setState(() {
                  _getPosition().then((position){
                    print(position.toString());

                    Navigator.push(context, 
                      MaterialPageRoute(builder:  (context) => BusinessSelectPage(position))
                    );
                  });
                });
              },
            ),
          ),
          Container(
            color: Colors.brown,
            child: Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }
  Map<String, String> _parseString() {
    return _parseBCCard(_controller.text);
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

  Future _getPosition() async {
    Map<String, String> parsedList = _parseString();
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