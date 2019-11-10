import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/model/hotelListData.dart';
import 'package:credit_card_sms_receiver/theme/hotelAppTheme.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'customwidget/hotelListView.dart';

class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage>with TickerProviderStateMixin  {
//  AnimationController animationController;
  ScrollController _scrollController = new ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));


  @override
    void initState() {
//    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
//    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Scaffold(
        appBar: AppBar(),
        body: getItemList()
      ),
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
        else {
          return ListView(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new HotelListView(
                hotelData: new HotelListData(document),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Explore",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.mapMarkerAlt),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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


