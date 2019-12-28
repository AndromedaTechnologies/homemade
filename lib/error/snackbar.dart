

import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class CustomSnackBar{

  static SnackBar_3Error(_scaffoldKey,{IconData leadingIcon,String title}){
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }catch(e){

    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              leadingIcon,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyles.textStyleNormalWhite(fontSize: 14),
              )
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        backgroundColor: MColor.error,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 10.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static SnackBar_InfiniteError(_scaffoldKey,{IconData leadingIcon,String title}){
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }catch(e){

    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              leadingIcon,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width:5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyles.textStyleNormalWhite(fontSize: 14),

              ),
            ),
          ],
        ),
        duration: Duration(hours: 3),
        backgroundColor: MColor.error,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 10.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static SnackBar_ButtonError(GlobalKey<ScaffoldState> _scaffoldKey,{IconData leadingIcon,String title,String buttonText, Function btnFun}){
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }catch(e){

    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              leadingIcon,
              color: Colors.white,
              size:18,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyles.textStyleNormalWhite(fontSize: 14),

              ),
            ),
          ],
        ),
        action: SnackBarAction(label: buttonText, onPressed:
          btnFun
        ,textColor: Colors.white,),
        duration: Duration(hours: 3),
        backgroundColor: MColor.error,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 10.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  static SnackBar_3Success(_scaffoldKey,{IconData leadingIcon,String title}){
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }catch(e){

    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              leadingIcon,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyles.textStyleNormalWhite(fontSize: 14),

              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        backgroundColor: MColor.application,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)),
        elevation: 10.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}