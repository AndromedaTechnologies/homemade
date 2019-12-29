import 'package:flutter/material.dart';
import 'package:homemade/model/loginModel.dart';
import 'package:homemade/view/landing/splash.dart';
import 'package:homemade/view/landing/walkthrought.dart';
import 'package:homemade/view/wrapper.dart';

import 'model/UserModel.dart';
import 'res/globalClass.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool screenCheck = false;
  bool isAnyLoginInUserToken = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      _checkLoginUser();
    });
  }

  _checkLoginUser() async {
    String token =
    await UserModel.getToken();
    print(token);
    if (token != null) {
      setState(() {
        screenCheck = true;
        isAnyLoginInUserToken = true;
      });
    }else{
      setState(() {
        screenCheck = true;
        isAnyLoginInUserToken = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Global.navigatorKey,
      title: 'Home Made',
      theme: ThemeData(
        primarySwatch: Colors.green,
        splashColor: Colors.white,
      ),
      home: screenCheck ? isAnyLoginInUserToken ? WrapperStream() : WalkThrough() : SplashScreen(),
    );
  }
}