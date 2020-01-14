import 'package:homemade/model/UserModel.dart';

class MyProfileModel {
  UserModel user;

  MyProfileModel({this.user});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
