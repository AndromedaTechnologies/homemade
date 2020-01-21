import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/SearchTextField.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition cameraPosition;
  BitmapDescriptor _markerIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.675176, 73.0131023),
    zoom: 14.4746,
  );

  TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);

    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          compassEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationEnabled: true,
          rotateGesturesEnabled: true,
          markers: _createMarker(),
          onCameraMove: (CameraPosition position) {
            cameraPosition = position;
            print(position.target.longitude);
            print(position.target.latitude);
          },
        ),
        Positioned(
          top: 70,
          left: 30,
          right: 30,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(4, 2))
                ]),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    locationImage,
                    width: 20,
                    height: 20,
                    color: MColor.application.withOpacity(0.7),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SearchTextField(
                    controller: _searchController,
                    hint: "Islamabad, Pakistan",
                    textInputType: TextInputType.text,

                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.clear,
                    size: 28,
                    color: MColor.application.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Set<Marker> _createMarker() {
    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
    // https://github.com/flutter/flutter/issues/28312
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(33.675176, 73.0131023),
        draggable: false,
//        icon: _markerIcon
      ),
    ].toSet();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(20, 20));

      BitmapDescriptor.fromAssetImage(
        imageConfiguration,
        locationImage,
      ).then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }
}
