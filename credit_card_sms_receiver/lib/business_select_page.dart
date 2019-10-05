import 'package:flutter/material.dart';

class BusinessSelectPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String business;

  BusinessSelectPage(this.latitude, this.longitude, this.business);

  @override
  _BusinessSelectPageState createState() => _BusinessSelectPageState();
}

class _BusinessSelectPageState extends State<BusinessSelectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
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
    );
  }
}