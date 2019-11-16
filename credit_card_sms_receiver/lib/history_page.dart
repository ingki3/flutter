import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/customcomponent/visitedBusinessListTile.dart';
import 'package:credit_card_sms_receiver/model/visitedBusinessListTileData.dart';
//import 'package:credit_card_sms_receiver/theme/hotelAppTheme.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage>with TickerProviderStateMixin  {
//  AnimationController animationController;
//  ScrollController _scrollController = new ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));


  @override
    void initState() {
  //  animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
//    animationController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: getItemList(),
    );
  }

  Widget getItemList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('post')
              .where("userId", isEqualTo: userStatus.uid)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return const Text("Loading......");
        }

        var items = snapshot.data?.documents ?? [];
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return new VisitedBusinessListTile(
              item: new VisitedBusinessListTileData(items[index])
            );
          },
        );
      },
    );
  }


}



/*
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
*/


