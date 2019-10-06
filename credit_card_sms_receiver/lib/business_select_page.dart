import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessSelectPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String business;

  BusinessSelectPage(this.latitude, this.longitude, this.business);

  @override
  _BusinessSelectPageState createState() => _BusinessSelectPageState();
}

class _BusinessSelectPageState extends State<BusinessSelectPage> {
  var itemList;
  Widget safeArea;

  @override
  void initState() {
    print("Mark 2 ***************************");
    _searchNearby(widget.latitude, widget.longitude, widget.business);
    super.initState();
    print("Mark 3 ***************************");


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: this.safeArea,
    );
  }

  Future _searchNearby(double latitude, double longitude, String business) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyC9kSjaT9qIaGcNBrQifVb-TRmr64VeBtU&location=$latitude,$longitude&radius=10000&keyword=$business';
    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      this.itemList = json.decode(response.body);
      this.safeArea = SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext ctxt, int Index){
            print("Mark 44 ***************************");
            print(itemList[index]["name"]);
            return Card(
              child:  ListTile(
                leading: Icon(Icons.map),
                title:itemList[index]["name"]),
            );
          },
          itemCount: itemList.length,
        ),
      );
      print("Mark 22 ***************************");
    } else {
      throw Exception('An error occurred getting places nearby');
    }


  }
}



/*
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.map),
              title: Text("Business Name")
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.map),
              title: Text("Business Name")
            ),
          ),
        ],
      ),
*/