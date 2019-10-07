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
    super.initState();
    print("Mark 3 ***************************");


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: projectWidget(),
    );
  }



  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        print("Project Snap Length : ${projectSnap.data.length}");
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
            print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            var project = projectSnap.data[index];
            return Column(
              children: <Widget>[
                Card(
                  child:  ListTile(
                    leading: Icon(Icons.map),
                    title: Text(project[index]),
                  ),
                ),
              ],
            );
          },
        );
      },
      future: getProjectDetails(widget.latitude, widget.longitude, widget.business),
    );
  }

  Future getProjectDetails(double latitude, double longitude, String business) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyC9kSjaT9qIaGcNBrQifVb-TRmr64VeBtU&location=$latitude,$longitude&radius=10000&keyword=$business';
    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Mark 2-1 ***************************");
      print(json.decode(response.body));
      return json.decode(response.body);
    }
    else{
      return Container();
    }
  }
}



/*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }





              Card(
                child:  ListTile(
                  leading: Icon(Icons.map),
                  title:itemList[0]["name"]),
              ),


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



  Future _searchNearby(double latitude, double longitude, String business) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyC9kSjaT9qIaGcNBrQifVb-TRmr64VeBtU&location=$latitude,$longitude&radius=10000&keyword=$business';
    print(url);

    final response = await http.get(url);
    print("Status code : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Mark 2-1 ***************************");
      this.itemList = json.decode(response.body);
      print("Mark 2-2 ***************************");
      this.safeArea = SafeArea(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.map),
                title: Text(itemList[0])
              ),
            ),
          ],
        ),
      );
      print("Item Count : ${itemList.length}");
      print("Mark 22 ***************************");
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }
*/