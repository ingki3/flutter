import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed: _changeMessage),
      appBar : AppBar(
        title: Text(widget.title),
      ),
      body: Text(_message, style: TextStyle(fontSize: 30))
    );
  }
        
  void _changeMessage() {
    setState(() {
      _message = 'Welcome to my app';
    });
  }
}