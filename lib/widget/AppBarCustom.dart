

import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/textStyle.dart';

Widget AppBarCustom(String title){
  return AppBar(
    backgroundColor: MColor.application,
    title: Text(title,style: TextStyles.textStyleBoldWhite(spacing: 7,fontSize: 20),),
    centerTitle: true,
//    titleSpacing: 1.2,
  );
}