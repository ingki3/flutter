import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';

class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('post')
                .where("userId", isEqualTo: userStatus.uid)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Text("Loading......");
          }
          else {
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['name']),
                  subtitle: new Text(document['currentTime'].toDate().toString()),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}