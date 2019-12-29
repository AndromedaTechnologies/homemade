
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class RoundedBorderButton extends StatelessWidget {

  final String text;
  final Function onTap;
  final double width;
  final double height;
  final double borderRadius;
  final bool boldText;

  RoundedBorderButton({@required this.text, this.onTap, this.width,this.height,this.borderRadius=200,this.boldText=true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?? MySize.of(context).fitWidth(80),
        height: height??60,
        decoration: BoxDecoration(
          color: MColor.application,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(color: MColor.lightGreyB6,offset: Offset(0,4),blurRadius: 4,spreadRadius: 0)
          ]
        ),
        child: Center(child: Text(
          boldText ? text.toUpperCase():text,
          style: boldText ? TextStyles.textStyleBoldWhite():TextStyles.textStyleNormalWhite(),
        )),


      ),
    );
  }
}
