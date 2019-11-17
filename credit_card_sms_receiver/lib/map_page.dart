import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:credit_card_sms_receiver/rate_page.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MapPage extends StatefulWidget {
  final SearchResult result;

  MapPage(this.result);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition position;
  String markerId; 

  @override
  void initState() {
    super.initState();
    this.position = CameraPosition(
      target: LatLng(widget.result.currentLatitude, widget.result.currentLongitude),
      zoom: 18.0,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: position,
                  markers: _getMarkers(),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            _getSelectedItem()
          ],
        ),
      ),
    );
  }

  Widget _getSelectedItem() {
    return StreamBuilder<QuerySnapshot> (
      stream: Firestore.instance.collection('post')
              .where("id", isEqualTo: markerId)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
        return const Text("Loading......");
        }

        var items = snapshot.data?.documents ?? [];

        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: CustomAppTheme.buildLightTheme().backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  items[0]["name"],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.all(8.0)
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      items[0]["address"],
                                      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      size: 12,
                                      color: CustomAppTheme.buildLightTheme().primaryColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "8 km to city",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: <Widget>[
                                      SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: 5,
                                        rating: 3.5,
                                        size: 20,
                                        color: CustomAppTheme.buildLightTheme().primaryColor,
                                        borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                                      ),
                                      Text(
                                        " 7 Reviews",
                                        style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  child: Text("Yes, I'm Here. I want to Rate!!", style: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.bold),),
                                  textColor: Colors.blue,
                                  onPressed: (){
/*
                                    Navigator.push(context, 
                                        MaterialPageRoute(builder:  (context) => RatePage(item:items[0])
                                      )
                                    );
                                    */
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );

      },
    );







  }


  Set<Marker> _getMarkers() {
    Set<Marker> result = Set();
    for (var item in widget.result.resultItem){
      result.add(
        Marker(
          markerId: MarkerId(item.id),
          position: LatLng(item.latitude, item.longitude),
          infoWindow: InfoWindow(
            title: item.name,
            snippet: item.address,
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            setState(() {
              this.markerId = item.id;
            });
          },
        )
      );
    }

    return result;
  }
}