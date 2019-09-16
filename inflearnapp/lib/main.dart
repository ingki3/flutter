import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cupertino_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//    home: CupertinoPage(),
      home: MyAppStateful(title: 'Hello World'),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  final String title;

  const MyAppStateful({Key key, this.title}) : super(key: key);

  @override
  _MyAppStatefulState createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  String _message = 'Hello World';
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed: _changeMessage),
      appBar : AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget>[
            Text(_message, style: TextStyle(fontSize: 30)),
            Text('$_counter', style: TextStyle(fontSize: 30)),
            RaisedButton(
              child: Text('Move page'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CupertinoPage()));
              },
            )
          ], ))
    );
  }
        
  void _changeMessage() {
    setState(() {
      _message = 'Welcome to my app';
      _counter ++;
    });
  }
}