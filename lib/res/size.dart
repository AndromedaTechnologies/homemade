

import 'package:flutter/cupertino.dart';

import 'globalClass.dart';

class MySize {

  BuildContext context;


  MySize.of(this.context);
  ///Longest Side Adjustment with respect to IPHONE 6
  static double getLongestSide(double pixel){
    Size size = MediaQuery.of(Global.navigatorKey.currentContext).size;
    return size.longestSide* (pixel/667) ;
  }

  static double getSizeWithAspectRatio(double pixel){
    Size size = MediaQuery.of(Global.navigatorKey.currentContext).size;
    return size.longestSide* (pixel/667) *(size.shortestSide/size.longestSide) ;
  }

  ///Shortest Side Adjustment with respect to IPHONE 6
  static double getShortestSide(double pixel){
    Size size = MediaQuery.of(Global.navigatorKey.currentContext).size;
    return size.shortestSide * (pixel/375);
  }

  double fitWidth(double percent){
    Size size = MediaQuery.of(context).size;
    return size.width * (percent/100);
  }

  double fitHeight(double percent){
    Size size = MediaQuery.of(context).size;
    return size.height * (percent/100);
  }

}