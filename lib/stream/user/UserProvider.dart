import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homemade/view/classes/NavigationBar.dart';
import '../../model/UserStreamModel.dart';
import 'notifier.dart';

class UserProvider with ChangeNotifier {
  StreamController<UserStreamModel> _streamController =
      StreamController<UserStreamModel>();

  UserStreamModel user = UserStreamModel();

  List<NavigationBar> list = [
    NavigationBar(
        text: "Home", imageUrl: "", selected: true),
    NavigationBar(
        text: "Food", imageUrl: "", selected: false),
    NavigationBar(
        text: "Profile", imageUrl: "", selected: false),
  ];


  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  Stream<UserStreamModel> get status {
    return _streamController.stream;}

  void dispatch(UserModelNotifier event) async {
    if (event is ReloadUserData) {
      user = UserStreamModel();
      await user.getModelFromPrefs();
    _streamController.add(user);
    } else if (event is GetUserData) {

      user = UserStreamModel();
      _streamController.add(user);

      await user.getModelFromPrefs();
    _streamController.add(user);
    }
  }




}
