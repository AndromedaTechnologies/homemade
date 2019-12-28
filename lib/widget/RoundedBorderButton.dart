
import 'package:flutter/material.dart';
import 'package:homemade/res/color.dart';
import 'package:homemade/res/size.dart';
import 'package:homemade/res/textStyle.dart';

class RoundedBorderButton extends StatelessWidget {

  final String text;
  final Function onTap;
  final double width;
  final double height;

  RoundedBorderButton({@required this.text, this.onTap, this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?? MySize.of(context).fitWidth(80),
        height: height??60,
        decoration: BoxDecoration(
          color: MColor.application,
          borderRadius: BorderRadius.circular(200),
        ),
        child: Center(child: Text(
          text.toUpperCase(),
          style: TextStyles.textStyleBoldWhite(),
        )),


      ),
    );
  }
}
