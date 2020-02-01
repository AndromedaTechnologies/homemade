import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:homemade/error/snackbar.dart';
import 'package:homemade/model/Facebook_User.dart';

import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class FacebookAuth {
  FacebookLogin _facebookLogin = FacebookLogin();

  signInWithFaceBook(
      {
      GlobalKey<ScaffoldState> scaffoldKey,
      Function loginSuccessful}) async {


    await _facebookLogin.currentAccessToken.then((token) async {
      print("acess token $token");
      if (token != null) {
        await _facebookLogin.logOut();
      }

      return;
    });

    _facebookLogin.logIn(['email', 'public_profile', 'user_birthday','user_gender']).then(
        (result) async {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          print("Login");
          print(result.accessToken.token);
          print(result.accessToken.userId);
          print(result.accessToken.permissions);
          print(result.accessToken.toMap());
          print(result.accessToken);
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture,first_name,last_name,gender,birthday,email&access_token=${result.accessToken.token}');
          print(graphResponse.body);

          Facebook facebookuser =
              Facebook.fromJson(jsonDecode(graphResponse.body));
          loginSuccessful(facebookuser);

//          isLogin
//              ? _login(facebookuser, context)
//              : _signUp(facebookuser, context);
//          {
//            Navigator.of(context).push(PageTransition(
//                child: Register(faceeook: facebookuser),
//                type: PageTransitionType.downToUp));
//          }
          break;
        case FacebookLoginStatus.error:
          print("Error");

          break;
        case FacebookLoginStatus.cancelledByUser:
          print("Cancelled by User");
          CustomSnackBar.SnackBar_3Error(scaffoldKey,
              leadingIcon: Icons.error_outline,
              title: "Facebook Login Failed!",);
          break;
      }
    }).catchError((err) {
      print("Error $err");
    });
  }

//facebook_token

}
