import 'dart:convert';

import 'package:credit_card_sms_receiver/business_select_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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
                print(_parseString());

                double latitude;
                double longitude;
                setState(() {
                  _getPosition().then((position){
                    print(position.latitude);
                    print(position.longitude);
                    latitude = position.latitude;
                    longitude = position.longitude;
                    _searchNearby(position.latitude, position.longitude, '재연비타민');
                  });
                });

                

                Navigator.push(context, 
                  MaterialPageRoute(builder:  (context) => BusinessSelectPage(latitude, longitude, "재연비타민"))
                );
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
  String _parseString() {
    return _parseBCCard(_controller.text);
  }

  String _parseBCCard(String str) {
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

    return (
      '''
        {
          "cardName" : "$cardName",
          "Spending" : "$spending",
          "month" : "$month",
          "day" : "$day",
          "hour" : "$hour",
          "minute" : "$minute",
          "business" : "$business"
        }
      '''
    );
  }

  Future _getPosition() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

// 1
  Future _searchNearby(double latitude, double longitude, String business) async {

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyC9kSjaT9qIaGcNBrQifVb-TRmr64VeBtU&location=$latitude,$longitude&radius=10000&keyword=$business';
    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }
}