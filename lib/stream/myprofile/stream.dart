import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/model/myprofile.dart';
import 'package:homemade/res/stringapi.dart';
import 'package:homemade/server/GeneralAPI.dart';
import 'package:homemade/stream/myprofile/state.dart';

import 'event.dart';

class MyProfileStream {
  final GlobalKey<ScaffoldState> _scaffold;

  final StreamController<MyProfileState> _controller =
      StreamController<MyProfileState>();

  MyProfileModel _myProfileModel;

  Stream<MyProfileState> get myProfileStream => _controller.stream;

  API api;

  MyProfileStream(this._scaffold);

  _getProfileData() async {
    try {
      _controller.add(DataLoadingState());
      print("data loading state");
      api = API(_scaffold);

      Response response = await api.get(url: USER_DATA_URL);

      if (response != null && response.data is Map) {
        _myProfileModel = MyProfileModel.fromJson(response.data);
      }

      _controller.add(DataFetchedState(_myProfileModel));
    } catch (e) {
      _controller.add(ErrorState());
      print(e);
    }
  }

  void dispatch(MyProfileEvent event) {
    if (event is FetchData) {
      _getProfileData();
    }
  }
}
