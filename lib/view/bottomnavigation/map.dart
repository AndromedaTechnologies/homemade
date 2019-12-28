
import 'package:flutter/material.dart';
import 'package:homemade/res/textStyle.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Map/Food",
        style: TextStyles.textStyleBold(),
      ),
    );
  }
}
