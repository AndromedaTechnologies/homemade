import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homemade/model/locationModel.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/globalValues.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/widget/AppBarCustom.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:homemade/widget/SearchTextField.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class SelectLocationGoogleMaps extends StatefulWidget {
  final bool isUpdate;
  final LocationModel location;

  const SelectLocationGoogleMaps(
      {Key key, this.isUpdate = false, this.location})
      : super(key: key);

  @override
  _SelectLocationGoogleMapsState createState() =>
      _SelectLocationGoogleMapsState();
}

class _SelectLocationGoogleMapsState extends State<SelectLocationGoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition cameraPosition;

  String hintDefaultLocationText;

  TextEditingController _searchController;
  FocusNode _searchFocus = FocusNode();

  GoogleMapsPlaces _places;

  final _queryBehavior = BehaviorSubject<String>.seeded('');
  ValueChanged<PlacesAutocompleteResponse> onError;
  PlacesAutocompleteResponse _response;

  bool _searching = false;

  static final CameraPosition _initialLocation = CameraPosition(
    target: LatLng(33.675176, 73.0131023),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition = _initialLocation;
    if (widget.isUpdate) {
      _setUserLocation();
    }

    _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

    _searchController = TextEditingController();

    _queryBehavior.stream
        .debounceTime(const Duration(milliseconds: 300))
        .listen(doSearch);

    _searchController.addListener(() {
      _queryBehavior.add(_searchController.text);
    });

    _searchFocus.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration.zero, getCurrentLocationData);

//    _controller.
  }

  ///Google Place Fuctions
  Future<Null> doSearch(String value) async {
    if (mounted && value.isNotEmpty) {
      setState(() {
        _searching = true;
      });

      final res = await _places.autocomplete(
        value,
        language: "en",
//        sessionToken: widget.sessionToken,
        components: [Component(Component.country, "pk")],
      );

      if (res.errorMessage?.isNotEmpty == true ||
          res.status == "REQUEST_DENIED") {
        onResponseError(res);
      } else {
        onResponse(res);
      }
    } else {
      onResponse(null);
    }
  }

  @mustCallSuper
  void onResponseError(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    if (onError != null) {
      onError(res);
      print("ERROR $res");
    }

    setState(() {
      _response = null;
      _searching = false;
    });
  }

  @mustCallSuper
  void onResponse(PlacesAutocompleteResponse res) {
    if (!mounted) return;

    setState(() {
      _response = res;
      _searching = false;
    });

    if (_response != null)
      _response.predictions.forEach((pre) {
//        print(" Des ${pre.placeId} ${pre.description} ${pre.reference}"
//            " ${pre.types.toString()} "
//            " Len ${pre.matchedSubstrings.length} ${pre.terms.length} "
//            "Main ${pre.structuredFormatting.mainText} "
//            "Secondary ${pre.structuredFormatting.secondaryText} ");

//        pre.structuredFormatting.mainTextMatchedSubstrings.forEach((val){
//          print(val.);
//        });

//      pre.matchedSubstrings.forEach((str){
//        print("${pre.placeId} ${str.offset}");
//      });
//
//      pre.terms.forEach((trm){
//        print("${pre.placeId} ${trm.offset}");
//      });

//      _places.getDetailsByPlaceId(pre.placeId).then((placeDetailResponse){
//        print("${pre.placeId} ${placeDetailResponse.result.geometry.location.lat} ${placeDetailResponse.result.geometry.location.lng}");
//      });
      });

//          _places.getDetailsByPlaceId( _response.predictions[0].placeId).then((placeDetailResponse){
//        print("000 ${placeDetailResponse.result.geometry.location.lat} ${placeDetailResponse.result.geometry.location.lng}");
//      });
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
                initialCameraPosition: _initialLocation,
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
          _searchFieldPosition(),
          _searchDataPosition(),
          _gpsPosition(),
          _saveButtonPosition(),
        ],
      ),
    );
  }

  Widget _searchFieldPosition() {
    return Positioned(
      top: 40,
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
                hint: hintDefaultLocationText ?? "",
                textInputType: TextInputType.text,
                focusNode: _searchFocus,
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Icon(
                  Icons.clear,
                  size: 28,
                  color: MColor.application.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchDataPosition() {
    print("---------Focus ${_searchFocus.hasFocus}--------");
    return Positioned(
      top: 104,
      left: 30,
      right: 30,
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 600),
        crossFadeState: _searchFocus.hasFocus
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 0)
          ]),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _response?.predictions?.length ?? 0,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _getPlaceCordinates(_response.predictions[index].placeId);
                _searchController.text =
                    _response.predictions[index].structuredFormatting.mainText;

                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: _searchItem(
                  mainText: _response?.predictions[index]?.structuredFormatting
                          ?.mainText ??
                      "",
                  secondayText: _response?.predictions[index]
                          ?.structuredFormatting?.secondaryText ??
                      ""),
            ),
          ),
        ),
        secondChild: Container(),
      ),
    );
  }

  Widget _searchItem({String mainText = "", String secondayText = ""}) {
    print("---------Search Item $mainText --------");
    return Container(
        width: double.maxFinite,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 0.5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: RichText(
            text: TextSpan(
                text: mainText,
                style: TextStyles.textStyleNormalGreySemiBold(),
                children: [
              TextSpan(
                text: ", " + secondayText,
                style: TextStyles.textStyleNormalGreySemiBold(),
              )
            ])));
  }

  Widget _gpsPosition() {
    return Positioned(
      bottom: 100,
      right: 20,
      child: MediaQuery.of(context).viewInsets.bottom != 0
          ? Container()
          : Container(
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Center(
                child: IconButton(
                  onPressed: _moveToCurrentLocation,
                  icon: Icon(
                    Icons.gps_fixed,
                    color: MColor.application,
                    size: 30,
                  ),
                ),
              )),
    );
  }

  Widget _saveButtonPosition() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: MediaQuery.of(context).viewInsets.bottom != 0
          ? Container()
          : Center(
              child: RoundedBorderButton(
              text: "Save",
//                width: M,
              onTap: _getCordinatesDetails,
            )),
    );
  }

  _setUserLocation() {
//    33.675176, 73.0131023
    cameraPosition = CameraPosition(
      target: LatLng(double.parse(widget?.location?.latitude ?? "33.675176"),
          double.parse(widget?.location?.longitude ?? "73.0131023")),
      zoom: 14.4746,
    );
  }

  ///Funcitons
  _getCordinatesDetails() async {
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        cameraPosition.target.latitude, cameraPosition.target.longitude);

    Navigator.of(context).pop(placemark.length > 0 ? placemark[0] : null);
  }

  getCurrentLocationData() async {
    print(
        "----------- Geolocator lat ${cameraPosition.target.latitude} long ${cameraPosition.target.longitude}------");
    List<Placemark> placeMark =
        await Geolocator().placemarkFromCoordinates(33.675176, 73.0131023);
//        cameraPosition.target.latitude, cameraPosition.target.longitude);

    hintDefaultLocationText =
        placeMark[0].name + " " + placeMark[0].subLocality;
    setState(() {});
  }

  _moveToCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _moveCamera(position.latitude, position.longitude);
  }

  _moveCamera(double latitude, double longitude) {
    cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 18.4746,
    );
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);
    _controller.future.then((mapController) {
      mapController.animateCamera(cameraUpdate);
    });
  }

  _getPlaceCordinates(String placeId) async {
    PlacesDetailsResponse details = await _places.getDetailsByPlaceId(placeId);
    if (details.isOkay) {
      print(details.result);
      print(
          "${details.result.geometry.location.lat} ${details.result.geometry.location.lng} ");

      _moveCamera(details.result.geometry.location.lat,
          details.result.geometry.location.lng);
    }
  }

//  Future<void> _getCordinatesOfPointerLocation() async {
//    final GoogleMapController controller = await _controller.future;
//    _controller.future.then((google){
//      google.
//    });
//    controller.getScreenCoordinate(_controller.future.then((gg){gg.getScreenCoordinate()}))

//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}
