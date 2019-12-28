
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/error/snackbar.dart';

class DebugError{

  static CheckMap(var data,GlobalKey<ScaffoldState> scaffold){
    if(data is Map){
     data.forEach((key,value){
       CheckMap(value, scaffold);
     });
    }else if(data is String){
      CustomSnackBar.SnackBar_3Error(scaffold,title: data,leadingIcon: Icons.error_outline);
    }
    else if(data is List){
      if(data.length>0)
        CheckMap(data[0], scaffold);
      else
        CustomSnackBar.SnackBar_3Error(scaffold,title: data.toString(),leadingIcon: Icons.error_outline);
    }
  }
}