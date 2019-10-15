import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:credit_card_sms_receiver/sms_input_page.dart';

import 'package:sms/sms.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SmsReceiver _receiver;

  @override
  void initState() {
    super.initState();
    _receiver = new SmsReceiver();
    _receiver.onSmsReceived.listen((SmsMessage msg) => reactiveApp(msg.body));
  }

  void reactiveApp( String msgBody ) {
    startServiceInPlatform();
    print(msgBody);
    Navigator.push(context, 
                MaterialPageRoute(builder:  (context) => SmsInputPage(msgBody))
              );
  }

  void startServiceInPlatform() async {
    if(Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.credit_card_sms_receiver");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: SmsInputPage(""),
    );
  }
}

/*
import 'package:credit_card_sms_receiver/sms_input_page.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:sms/sms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  void startServiceInPlatform() async {
    if(Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.credit_card_sms_receiver");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    startServiceInPlatform();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: SmsInputPage(""),
    );
  }
}
*/





