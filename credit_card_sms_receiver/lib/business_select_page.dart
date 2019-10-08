import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:flutter/material.dart';


class BusinessSelectPage extends StatefulWidget {
  final SearchResult result;

  BusinessSelectPage(this.result);

  @override
  _BusinessSelectPageState createState() => _BusinessSelectPageState();
}

class _BusinessSelectPageState extends State<BusinessSelectPage> {
  var itemList;
  Widget safeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.result.resultItem.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.map),
              title:Text(widget.result.resultItem[index].name),
            )
          );              
        }
      ),
    );
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