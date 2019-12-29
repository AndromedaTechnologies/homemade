

import 'package:homemade/stream/UserProviderInstance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserModel.dart';

class LoginModel {
  String token;
  UserModel user;

  LoginModel({this.token, this.user});


  prefsSet() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(token!=null){
      prefs.setString("token", token);
    }
    
    if(user!=null){
      prefs.setString("email", user.email);
      prefs.setString("firstName", user.firstName);
      prefs.setString("lastName", user.lastName);
      prefs.setString("phoneNumber", user.phoneNumber);
      prefs.setString("image", user.image);
      prefs.setString("role", user.role);

      ///Create Notifier here
    }

  }

  clearPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static signOut()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    UserInstance.userProvider.dispose();
    UserInstance.userProvider = null;
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}