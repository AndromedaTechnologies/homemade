import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/widget/AppBarCustom.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'dart:math' as math;

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition cameraPosition;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.675176, 73.0131023),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _controller.
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom("Select Location"),
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                compassEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMove: (CameraPosition position) {
                  cameraPosition = position;
                  print(position.target.longitude);
                  print(position.target.latitude);
                },
              )),
          Center(
            child: Icon(
              Icons.radio_button_checked,
              color: MColor.applicationDark,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
                child: RoundedBorderButton(
              text: "Save",
//                width: M,
              onTap: () {},
            )),
          ),
        ],
      ),
    );
  }




  ///Funcitons


//  Future<void> _getCordinatesOfPointerLocation() async {
//    final GoogleMapController controller = await _controller.future;
//    _controller.future.then((google){
//      google.
//    });
//    controller.getScreenCoordinate(_controller.future.then((gg){gg.getScreenCoordinate()}))

//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}
