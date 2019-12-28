
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColor.white,
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              width: MySize.getLongestSide(100),
              height: MySize.getLongestSide(100),
              fit: BoxFit.contain,
              image: AssetImage(logoImage)),
//          Image.asset(logoImage,width: MySize.getLongestSide(100),height: MySize.getLongestSide(100),fit: BoxFit.contain,),
//          SizedBox(height: MySize.getLongestSide(10),),
          Text("find good food",style: TextStyles.textStyleLightItalic(fontSize: 20),)
        ],
      )),
    );
  }}

