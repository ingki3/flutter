import 'package:flutter/material.dart';

class SmsInputPage extends StatefulWidget {
  @override
  _SmsInputPageState createState() => _SmsInputPageState();
}

class _SmsInputPageState extends State<SmsInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
            
          );
        }
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Text('Input SMS Mesaage',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          MaterialButton(
            child: Text('Input SMS', style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            height: 48.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}