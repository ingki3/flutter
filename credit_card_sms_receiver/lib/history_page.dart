import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:credit_card_sms_receiver/business_result.dart';
//import 'package:credit_card_sms_receiver/customcomponent/currentBusinessListTile.dart';
import 'package:credit_card_sms_receiver/customcomponent/custom_app_bar.dart';
import 'package:credit_card_sms_receiver/customcomponent/visitedBusinessListTile.dart';
import 'package:credit_card_sms_receiver/model/visitedBusinessListTileData.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
//import 'package:credit_card_sms_receiver/user_status.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HitoryPage extends StatefulWidget {
  @override
  _HitoryPageState createState() => _HitoryPageState();
}

class _HitoryPageState extends State<HitoryPage>with TickerProviderStateMixin  {
//  AnimationController animationController;
//  ScrollController _scrollController = new ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));

  List<bool> isExpanded;

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
      body: Theme(
        data: CustomAppTheme.buildLightTheme(),
        child: Column(
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

  Widget getExpansionPanelList(List<DocumentSnapshot> document) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        this.isExpanded[index] = !isExpanded;
      },
      children: document.map<ExpansionPanel> ((DocumentSnapshot item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded){
            return VisitedBusinessListTile(item:VisitedBusinessListTileData(item));
          },
          isExpanded: true,
          body: AspectRatio(
            aspectRatio: 2,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(item["latitude"], item["longitude"]),
                zoom: 16.0
              ),
              markers: _getMarkers(item),
              onMapCreated: (GoogleMapController controller) {
              Completer().complete(controller);
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Set<Marker> _getMarkers(DocumentSnapshot item) {
    Set<Marker> result = Set();

    result.add(
      Marker(
        markerId: MarkerId(item["id"]),
        position: LatLng(item["latitude"], item["longitude"]),
        infoWindow: InfoWindow(
          title: item["name"],
          snippet: item["address"],
        ),
        icon: BitmapDescriptor.defaultMarker,
      )
    );

    return result;
  }
}



/*
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((BusinessResult item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            );
          },
          body: CurrentBusinessListTile(
            item: item
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
*/

/*
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return new VisitedBusinessListTile(
              item: new VisitedBusinessListTileData(items[index])
            );
          },
        );
*/