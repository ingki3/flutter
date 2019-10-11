import 'dart:async';

import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final SearchResult result;

  MapPage(this.result);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition position;

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
            Container(
              height: 350,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: position,
                markers: _getMarkers(),
                onMapCreated: (GoogleMapController controller) {
                 _controller.complete(controller);
                },
              ),
            ),
            Text("Hi, there?"),
          ],
        ),
      ),
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
        )
      );
    }

    return result;
  }
}