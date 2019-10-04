import 'package:flutter/material.dart';

class SmsInputPage extends StatefulWidget {
  @override
  _SmsInputPageState createState() => _SmsInputPageState();
}

class _SmsInputPageState extends State<SmsInputPage> {
  final _controller = TextEditingController();

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
                _parseString();
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
  void _parseString() {
    _parseBCCard(_controller.text);
  }

  void _parseBCCard(String str) {
    List<String> splitedStr = str.split('\n');
    for(var n in splitedStr) {
      print(n);
    }
  }
}
