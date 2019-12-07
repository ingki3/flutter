//import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:credit_card_sms_receiver/customcomponent/custom_app_bar.dart';
import 'package:credit_card_sms_receiver/customcomponent/visitedBusinessListTile.dart';
import 'package:credit_card_sms_receiver/model/visitedBusinessListTileData.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';

class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage> {

  @override
    void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Theme(
          data: CustomAppTheme.buildLightTheme(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(
                title:"History"
              ),
              Expanded(
                child: getItemList()
              ),
            ],
          )
        )
      );
    }

  Widget getItemList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('post')
//              .where("userId", isEqualTo: userStatus.uid)
              .orderBy('currentTime', descending: true)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return const Text("No result");
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