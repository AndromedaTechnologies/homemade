import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/imagestring.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';
import 'package:homemade/view/auth/login.dart';
import 'package:homemade/widget/RoundedBorderButton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

class WalkThrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: MColor.white,
      body: Stack(
        children: <Widget>[
          Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  width: MySize.of(context).fitWidth(80),
                  height: MySize.of(context).fitHeight(30),
                  fit: BoxFit.contain,
                  image: AssetImage(walkThroughImage)),


//          SizedBox(height: MySize.getLongestSide(10),),
              Text(
                "We will find the best!".toUpperCase(),
                style: TextStyles.textStyleBold(fontSize: 24),
              ),

              SizedBox(
                height: 10,
              ),

              ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MySize.of(context).fitWidth(62), minWidth: 0),
                  child: Center(
                    child: Text(
                      "Connecting you with the nearest chef for a healthier lifestyle!"
                          .toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyles.textStyleNormal(),
                    ),
                  )),

              Orientation.landscape == orientation
                  ? SizedBox(
                      height:10,
                    )
                  : Container(),
            ],
          )),
          Positioned(
            bottom: MySize.of(context).fitHeight(5),
            left: 0,
            right: 0,
            child: Center(
              child: RoundedBorderButton(
                text: "let's go",
                onTap: () {
                  Navigator.of(context).pushReplacement(PageTransition(
                      child: LoginView(), type: PageTransitionType.downToUp));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
