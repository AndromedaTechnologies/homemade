import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/view/user/chefSheet.dart';
import 'package:homemade/widget/ImageInitials.dart';
import 'package:homemade/widget/SearchTextField.dart';
import 'package:homemade/widget/TextFieldWIthImage.dart';
import 'package:transparent_image/transparent_image.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition cameraPosition;
  CameraPosition updatedPosition;
  BitmapDescriptor _markerIcon;

  bool showingMap = true;
  bool currentPosition = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.675176, 73.0131023),
    zoom: 14.4746,
  );

  TextEditingController _searchController;

  Stream<Position> currentPositionStream = Geolocator().getPositionStream();
  StreamSubscription<Position> currentPositionStreamSub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToCurrentLocationOneTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPositionStreamSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);

    return Stack(
      children: <Widget>[
        showingMap ? _map() : _products(),
        Positioned(
          bottom: 20,
          right: 15,
          child: InkWell(
            onTap: () {
              setState(() {
                showingMap = !showingMap;
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, blurRadius: 8, spreadRadius: 0)
                  ]),
              child: Center(
                child: Icon(
                  Icons.repeat,
                  color: MColor.application,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _map() {
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
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          markers: _createMarker(),
        ),
        Positioned(
          bottom: 90,
          right: 15,
          child: InkWell(
            onTap: () {
              setState(() {
                currentPosition = true;
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, blurRadius: 8, spreadRadius: 0)
                  ]),
              child: Center(
                child: Icon(
                  Icons.gps_fixed,
                  color: MColor.application,
                  size: 30,
                ),
              ),
            ),
          ),
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

  Widget _products() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top + 20,
            ),
            Container(
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
                      houseImage,
                      width: 30,
                      height: 30,
                      color: MColor.application.withOpacity(0.7),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SearchTextField(
                      controller: _searchController,
                      hint: "Search",
                      textInputType: TextInputType.text,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Check Map",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                              Image.asset(
                                mapImage,
                                width: 30,
                                height: 30,
                                color: MColor.application.withOpacity(0.7),
                              ),
                              Text(
                                "Islamabad",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Filter",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                              Image.asset(
                                filterImage,
                                width: 30,
                                height: 30,
                                color: MColor.application.withOpacity(0.7),
                              ),
                              Text(
                                "Default",
                                style: TextStyles.textStyleNormal(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Latest Dishes",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 260,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Most Popular",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 260,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                  productUI(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Top Chefs",
              style: TextStyles.textStyleHardBold(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 230,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                  productUI(topChefs: true),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget productUI({bool topChefs = false}) {
    return Container(
      width: 180,
      height: topChefs ? 230 : 260,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: MColor.lightGreyB6), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(foodImage),
            fit: BoxFit.cover,
            height: 130,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ImageInitials(
                      firstName: "Jane",
                      lastName: "Doe",
                      height: 50,
                      width: 50,
                      fontSize: 20,
                      imageURL: null,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Jane" + " " + "Doe",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textStyleHardBold(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                starImage,
                                height: 16,
                                width: 16,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "0.0",
                                style:
                                    TextStyles.textStyleStarBold(fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(0)",
                                style:
                                    TextStyles.textStyleBoldGrey(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                topChefs
                    ? Text.rich(TextSpan(
                        text: "City: ",
                        style: TextStyles.textStyleNormal(),
                        children: [
                            TextSpan(
                                text: "Islamabad",
                                style: TextStyles.textStyleBold().copyWith(
                                    color: MColor.application.withOpacity(0.8)))
                          ]))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Paratha Roll",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textStyleNormal(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    starImage,
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0.0",
                                    style: TextStyles.textStyleStarBold(
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "(0)",
                                    style: TextStyles.textStyleBoldGrey(
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Price ",
                                    style: TextStyles.textStyleNormal(
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "\$ 30",
                                    style: TextStyles.textStyleHardBold(
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(33.675176, 73.0131023),
          draggable: false,
          onTap: _markerTap,
          icon: _markerIcon),
    ].toSet();
  }

  _markerTap() {
    showChefBottomSheet(context);
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(20, 20));

      BitmapDescriptor.fromAssetImage(
        imageConfiguration,
        locationImageSmall,
      ).then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  _moveToCurrentLocationOneTime() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _moveCamera(position.latitude, position.longitude);
  }

  _moveToCurrentLocation() async {
    currentPositionStreamSub =
        currentPositionStream.listen((Position position) {
//      print("---------$position $currentPosition $showingMap");
      if (currentPosition && showingMap) {
        _moveCamera(position.latitude, position.longitude);
      }
    });
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  _moveCamera(double latitude, double longitude) {
    cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 18.4746,
    );
    updatedPosition = cameraPosition;
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    _controller.future.then((mapController) {
      mapController.animateCamera(cameraUpdate);
    });
  }

  _checkDifference() {
    if (((cameraPosition.target.longitude - updatedPosition.target.longitude)
                    .floor() >=
                -2 &&
            (cameraPosition.target.longitude - updatedPosition.target.longitude)
                    .floor() <=
                0) &&
        ((cameraPosition.target.latitude - updatedPosition.target.latitude)
                    .floor() >=
                -2 &&
            (cameraPosition.target.latitude - updatedPosition.target.latitude)
                    .floor() <=
                0)) {
    } else {
      currentPosition = false;
    }
  }
}
