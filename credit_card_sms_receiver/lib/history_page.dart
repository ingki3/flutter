import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_sms_receiver/model/hotelListData.dart';
import 'package:credit_card_sms_receiver/theme/hotelAppTheme.dart';
import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';

import 'customwidget/hotelListView.dart';

class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage>with TickerProviderStateMixin  {
//  AnimationController animationController;
  ScrollController _scrollController = new ScrollController();

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
      child: Container(
        child: Scaffold(
          appBar: AppBar(),
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        getSearchBarUI(),
                        getTimeDateUI(),
                      ],
                    );
                  }, childCount: 1),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: ContestTabHeader(
                    getFilterBarUI(),
                  ),
                ),
              ];
            },
            body: Container(
              child: StreamBuilder<QuerySnapshot>(
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
                        return new HotelListView(
                          hotelData: new HotelListData(document),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
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





}