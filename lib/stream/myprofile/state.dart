

import 'package:homemade/model/myprofile.dart';

class MyProfileState{

}

class DataFetchedState extends MyProfileState{
  MyProfileModel myProfileModel;

  DataFetchedState(this.myProfileModel);

  bool get hasData => myProfileModel!=null;

}

class DataLoadingState extends  MyProfileState {}

class ErrorState extends  MyProfileState {}
