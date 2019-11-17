import 'dart:async';

import 'package:credit_card_sms_receiver/business_result.dart';
import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class CurrentBusinessListTile extends StatefulWidget {
  final BusinessResult item;
  const CurrentBusinessListTile({Key key, this.item}) : super(key: key);
  @override
  _CurrentBusinessListTileState createState() => _CurrentBusinessListTileState();
}


class _CurrentBusinessListTileState extends State<CurrentBusinessListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.item.latitude, widget.item.longitude),
                      zoom: 16.0
                    ),
                    markers: _getMarkers(widget.item),
                    onMapCreated: (GoogleMapController controller) {
                    Completer().complete(controller);
                    },
                  ),
                ),
                Container(
                  color: CustomAppTheme.buildLightTheme().backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.item.address,
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
                                "km to city",
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
                                onRatingChanged: (v) {
                                  setState(() {
                                    widget.item.rating = v;
                                  });
                                },
                                size: 40,
                                color: CustomAppTheme.buildLightTheme().primaryColor,
                                borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                              ),
                              Text(
                                " Reviews",
                                style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _getMarkers(BusinessResult item) {
    Set<Marker> result = Set();

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

    print("Name : ${item.name}");
    print("Latitude : ${item.latitude}, Longitude : ${item.longitude}");
    return result;
  }
}

/*
class VisitedBusinessListTile extends StatelessWidget {
//  final VoidCallback callback;
  final BusinessResult item;

  const VisitedBusinessListTile({Key key, this.item}) : super(key: key);
//  const HotelListView({Key key, this.hotelData, this.animationController, this.animation, this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(item.latitude, item.longitude),
                      zoom: 16.0
                    ),
                    markers: _getMarkers(item),
                    onMapCreated: (GoogleMapController controller) {
                    Completer().complete(controller);
                    },
                  ),
                ),
                Container(
                  color: CustomAppTheme.buildLightTheme().backgroundColor,
                  child: Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.address,
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
                                    "km to city",
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
                                    onRatingChanged: (v) {
                                      setState(() {
                                        item.rating = v;
                                      });
                                    },
                                    size: 20,
                                    color: CustomAppTheme.buildLightTheme().primaryColor,
                                    borderColor: CustomAppTheme.buildLightTheme().primaryColor,
                                  ),
                                  Text(
                                    " Reviews",
                                    style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _getMarkers(BusinessResult item) {
    Set<Marker> result = Set();

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

    print("Name : ${item.name}");
    print("Latitude : ${item.latitude}, Longitude : ${item.longitude}");
    return result;
  }
}
*/