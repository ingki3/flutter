import 'package:credit_card_sms_receiver/main_loading.dart';
import 'package:credit_card_sms_receiver/root_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:sms/sms.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



//void main() => runApp(new MaterialApp(home: new RatePage()));
void main() => runApp(new MaterialApp(home: new MyApp()));


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final notifications = FlutterLocalNotificationsPlugin();
  SmsReceiver _receiver;

  @override
  void initState() {
    super.initState();

//    startServiceInPlatform();
  
    _receiver = new SmsReceiver();
    _receiver.onSmsReceived.listen((SmsMessage msg) => reactiveApp(msg));

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  void reactiveApp( SmsMessage msg ) {
    print("************************************************************************************************************");
    print(msg.body);
    
    showNotification(msg);
  }

  void startServiceInPlatform() async {
    if(Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.credit_card_sms_receiver");
      String data = await methodChannel.invokeMethod("startService");
      print("main.dart:startServiceInPlatform");
      debugPrint(data);
    }
  }

  Future onSelectNotification(String payload) async{
    debugPrint("payload : $payload");
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage(payload)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: RootPage(),
    );
  }

  void showNotification(SmsMessage msg) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    print('main.showNotification');
    await flutterLocalNotificationsPlugin.show(
        0, 'You are there!', 'Share your experience.', platform,
        payload: msg.body);
  }
}

/*

import 'package:credit_card_sms_receiver/test_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:credit_card_sms_receiver/sms_input_page.dart';

import 'package:sms/sms.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final notifications = FlutterLocalNotificationsPlugin();

  SmsReceiver _receiver;

  @override
  void initState() {
    super.initState();

    startServiceInPlatform();
    _receiver = new SmsReceiver();
    _receiver.onSmsReceived.listen((SmsMessage msg) => reactiveApp(msg));

    final settingAndroid = AndroidInitializationSettings('app_icon');
    final settingIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) =>
      onSelectedNotification(payload)
    );

    notifications.initialize(
      InitializationSettings(settingAndroid, settingIOS), onSelectNotification: onSelectedNotification
    );
  }



  Future onSelectedNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TestPage()),
      );


  void reactiveApp( SmsMessage msg ) {
//    startServiceInPlatform();
    print("************************************************************************************************************");
    print(msg.body);
    
    showNotification();
  }

  void startServiceInPlatform() async {
    if(Platform.isAndroid) {
      var methodChannel = MethodChannel("com.example.credit_card_sms_receiver");
      String data = await methodChannel.invokeMethod("startService");
      print("main.dart:startServiceInPlatform");
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

  void showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    print('main.showNotification');
    await notifications.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  NotificationDetails get _ongoing {
    final androidChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: true,
      autoCancel: false,
    );
    final iOSChannelSpecifics = IOSNotificationDetails();
    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
  }

  Future showOngoingNotification (
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      int id = 0,
    }
  ) => _showNotification(notifications, title: title, body: body, id: id, type: _ongoing);

  Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      @required NotificationDetails type,
      int id = 0,
    }
  ) => notifications.show(id, title, body, type);

}

















import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async{
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Local Notification'),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: showNotification,
          child: new Text(
            'Demo',
            style: Theme.of(context).textTheme.headline,
          ),
        ),
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    print('main.showNotification');
    await flutterLocalNotificationsPlugin.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }
}
*/



